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
    if @answer.save then redirect_to session[:prev_url] end
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
      params.require(:answer).permit(:question_id, :user_id, :text, :marks_integer)
    end
end
