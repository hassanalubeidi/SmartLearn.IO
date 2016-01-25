class AnswersController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all
  end

  def show
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new(:question=>@question)
    @answer.pictures.build
    session[:prev_url] = request.referer
  end

  def edit
  end

  def create

    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.question = @question
    @answer.user = current_user
    unless params[:answer][:picture_64] == nil then
        @answer.picture = decode_base64
    end
    @answer.save
    if @answer.save then
      attempted_question = AttemptedQuestion.create(answer_id: @answer.id, user_id: @answer.user.id, question_id: @question.id, objective_id: @question.main_question.objectives.last.id, topic_id: @question.main_question.objectives.last.topic.id , subject_id: @question.main_question.objectives.last.topic.subject.id)
      redirect_to(:back)
    end
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :user_id, :text, :marks_integer, :picture)
    end
    def decode_base64
        Rails.logger.info 'decoding base64 file'
        decoded_data = Base64.decode64(params[:answer][:picture_64][:base64])
        # create 'file' understandable by Paperclip
        data = StringIO.new(decoded_data)
        data.class_eval do
            attr_accessor :content_type, :original_filename
        end

        # set file properties
        data.content_type = params[:answer][:picture_64][:filetype]
        data.original_filename = params[:answer][:picture_64][:filename]

        # return data to be used as the attachment file (paperclip)
        data
    end
end
