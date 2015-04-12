class TestPapersController < ApplicationController
  before_action :set_test_paper, only: [:show, :edit, :update, :destroy]

  def index
    @test_papers = TestPaper.all
  end

  def show
  end

  def new
    @test_paper = TestPaper.new
    @question = Question.new
  end

  def edit
  end

  def create
    @test_paper = TestPaper.new(test_paper_params)
    @test_paper.save
  end

  def update
    @test_paper.update(test_paper_params)
  end

  def destroy
    @test_paper.destroy
  end

  private
    def set_test_paper
      @test_paper = TestPaper.find(params[:id])
    end

    def test_paper_params
      params.require(:test_paper).permit(:subject_id,:name , :questions, :date, :calc_allowed, questions_attributes: [:text, :attachment, :total_marks, lines_attributes: [ :id, :question_id, :objective_id, :_destroy ]])
    end
end
