class QuestionsController < ApplicationController
  before_filter :require_user_signed_in
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    unless @question.answers.where(:user => current_user).last == nil
      @marks = @question.answers.where(:user => current_user).last.marks_integer
    end
  end

  def new
    @test = 0
    @question = Question.new
    @question.objectives.build
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    if @question.total_marks == nil then
      @question.total_marks = 0
    end
    
    @question.save
    @question.objectives do |objective|
      objective.questions << question
    end
    redirect_to questions_path
  end

  def update
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
    @question.destroy
    redirect_to :back
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:topic_id, :attachment, :text, :total_marks, lines_attributes: [ :id, :question_id, :objective_id, :_destroy ])
    end
end
