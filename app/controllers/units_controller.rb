class UnitsController < ApplicationController
  before_filter :require_user_signed_in
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    @units = Unit.all
    respond_with(@units)
  end

  def show
    respond_with(@unit)
  end

  def new
    @unit = Unit.new
    respond_with(@unit)
  end

  def edit
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save
    respond_with(@unit)
  end

  def update
    @unit.update(unit_params)
    respond_with(@unit)
  end

  def destroy
    @unit.destroy
    respond_with(@unit)
  end

  private
    def set_unit
      @unit = Unit.find(params[:id])
    end

    def unit_params
      params.require(:unit).permit(:name, :subject_id)
    end
end
