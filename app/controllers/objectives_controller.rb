class ObjectivesController < ApplicationController
  require 'ParsePapers'
  before_action :set_objective, only: [:show, :edit, :update, :destroy, :test]

  def index
    @objectives = Objective.all
  end

  def show
    ques = ParsePapers::Question.new(3, "http://content.doublestruck.eu/?headermarks=51&doclist=%7CQSPS209%7CQS131A02%7CQS13307%7CQSPS204%7CQSPL212%7CQSPL208&headertime=70&lk=f8abcbb9858e2859e00a1d33941b22f1&headercomment=&headerauthor=&subject=AA_COM_D&headertitle=&type=QMEN&dl=false&headersubtitle=&returntype=1&headerdate=")
    @ques = ques.answer_html
    @ans = ques.answer_html
    @src = ques.source
  end

  def new
    @objective = Objective.new
  end

  def edit
  end

  def create
    @objective = Objective.new(objective_params)
    @objective.save
  end

  def update
    @objective.update(objective_params)
    redirect_to test_objective_path(@objective)
  end

  def destroy
    @objective.destroy
  end

  def test
  end

  private
    def set_objective
      @objective = Objective.find(params[:id])
    end

    def objective_params
      params.require(:objective).permit(:name,  :module_pack_info, :total_marks, :belongs_to,:_destroy,  flashcards_attributes: [:id, :text, :top, :bottom, keypoints_attributes: [:id, :text, :image, :_destroy ]])
    end
end
