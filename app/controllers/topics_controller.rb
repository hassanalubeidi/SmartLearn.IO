class TopicsController < ApplicationController
  before_filter :require_user_signed_in
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :edit_subject]

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def edit
    unless params[:go_back].blank?
      $go_back_to_improvement = params[:go_back].to_i
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.save
    respond_to do |format|
      if @topic.save
        format.html { redirect_to :back , notice: 'topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @topic.update(topic_params)
    respond_to do |format|
      
      if @topic.save
        if 1 == 1 then
          format.html { redirect_to improvement_path(Improvement.find_by(id: $go_back_to_improvement)), notice: $go_back_to_improvement }
        else
          format.json { render :show, status: :created, location: @topic }
        end
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit_subject
  end

  def destroy
    @topic.destroy
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name, :subject_id, objectives_attributes: [:id, :name])
    end
end
