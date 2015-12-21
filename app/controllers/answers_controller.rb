class AnswersController < ApplicationController
  before_filter :require_user_signed_in
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
end
