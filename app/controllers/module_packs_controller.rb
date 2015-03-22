class ModulePacksController < ApplicationController
  before_filter :require_user_signed_in
  before_action :set_module_pack, only: [:show, :edit, :update, :destroy]

  def index
    @module_packs = ModulePack.all
    @topics = Topic.all
  end

  def show
  end

  def new
    @module_pack = ModulePack.new
  end

  def edit
  end

  def create
    @module_pack = ModulePack.new(module_pack_params)
    @module_pack.save
  end

  def update
    @module_pack.update(module_pack_params)
  end

  def destroy
    @module_pack.destroy
  end

  private
    def set_module_pack
      @module_pack = ModulePack.find(params[:id])
    end

    def module_pack_params
      params.require(:module_pack).permit(:name, :topic_id)
    end
end
