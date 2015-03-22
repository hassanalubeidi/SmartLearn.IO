class SetGroupsController < ApplicationController
  before_filter :require_user_signed_in
  before_action :set_set_group, only: [:show, :edit, :update, :destroy]

  def index
    @set_groups = SetGroup.all
    
  end

  def show
    
  end

  def new
    @set_group = SetGroup.new
    
  end

  def edit
  end

  def create
    @set_group = SetGroup.new(set_group_params)
    @set_group.save
    
  end

  def update
    @set_group.update(set_group_params)
    
  end

  def destroy
    @set_group.destroy
    
  end

  private
    def set_set_group
      @set_group = SetGroup.find(params[:id])
    end

    def set_group_params
      params.require(:set_group).permit(:name, :year, :subject_id)
    end
end
