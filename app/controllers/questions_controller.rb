class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
      @marks = @question.answers.where(:user => current_user).last.marks_integer
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.save
    redirect_to questions_path
  end

  def update
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:topic_id, :text, :total_marks)
    end
end
