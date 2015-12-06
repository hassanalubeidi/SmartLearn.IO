class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]

  def index
    @interventions = Intervention.all
  end

  def show
  end

  def new
    @intervention = Intervention.new
  end

  def edit
  end

  def create
    @intervention = Intervention.new(intervention_params)
    @intervention.save
  end

  def update
    @intervention.update(intervention_params)
  end

  def destroy
    @intervention.destroy
  end

  private
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    def intervention_params
      params.require(:intervention).permit(:problem, :fix, {:answer_ids => []} )

    end
end
