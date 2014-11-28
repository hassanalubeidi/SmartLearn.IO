class ArcticlesController < ApplicationController
  before_action :set_arcticle, only: [:show, :edit, :update, :destroy]

  def index
    @arcticles = Arcticle.all
    respond_with(@arcticles)
  end

  def show
    respond_with(@arcticle)
  end

  def new
    @arcticle = Arcticle.new
    respond_with(@arcticle)
  end

  def edit
  end

  def create
    @arcticle = Arcticle.new(arcticle_params)
    @arcticle.save
    respond_with(@arcticle)
  end

  def update
    @arcticle.update(arcticle_params)
    respond_with(@arcticle)
  end

  def destroy
    @arcticle.destroy
    respond_with(@arcticle)
  end

  private
    def set_arcticle
      @arcticle = Arcticle.find(params[:id])
    end

    def arcticle_params
      params.require(:arcticle).permit(:title, :body, :references)
    end
end
