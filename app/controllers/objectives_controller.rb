class ObjectivesController < ApplicationController
  require 'ParsePapers'
  before_action :set_objective, only: [:show, :edit, :update, :destroy, :test]

  def index
    @objectives = Objective.all
  end

  def show
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
