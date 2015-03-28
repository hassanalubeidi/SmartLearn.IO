class ImprovementsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy, :index]

  before_action :set_improvement, only: [:show, :edit, :update, :destroy, :add_review]

  # GET /improvements
  # GET /improvements.json
  def index
    @improvements = current_user.improvements
  end
  def add_review
    Review.create :user => current_user, :improvement => @improvement
    redirect_to root_path, notice: 'Improvement was successfully created.'
  end
  def set_user_as_teacher
    @user = User.find(params[:id])
    if current_user.power == "admin" 
      @user.update(:power => "teacher")
      redirect_to root_path, status: "User is now a teacher"
    else
      render text: "failure" + @user.username
    end
  end
  def set_user_as_student
    @user = User.find(params[:id])
    if current_user.power == "admin" 
      @user.update(:power => "student")
      redirect_to root_path, success: "User is now a student"
    else
      render text: "failure" + @user.username
    end
  end


  # GET /improvements/1
  # GET /improvements/1.json
  def show
  end

  # GET /improvements/new
  def new
    @improvement = Improvement.new
    @subjects = Subject.all
    @subjects_array = []
    @subjects.each do |subject|
      @subjects_array.push(subject.name)
    end
  end

  # GET /improvements/1/edit
  def edit
  end

  # POST /improvements
  # POST /improvements.json
  def create
    @improvement = Improvement.new(improvement_params)
    @improvement.user = current_user

    respond_to do |format|
      if @improvement.save
        format.html { 
          unless @improvement.topic.subject.blank?
            redirect_to @improvement, :flash => { :success => "Improvement was successfully created." }
          else 
            redirect_to edit_topic_path(@improvement.topic, {:go_back => @improvement.id }), :flash => { :warning => "This topic needs to assigned to a subject" }
          end
        }
        format.json { render :show, status: :created, location: @improvement }
      else
        format.html { render :new }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /improvements/1
  # PATCH/PUT /improvements/1.json
  def update
    respond_to do |format|
      if @improvement.update(improvement_params)
        format.html { redirect_to @improvement, :flash => { :success => "Improvement was successfully updated." } }
        format.json { render :show, status: :ok, location: @improvement }
      else
        format.html { render :edit }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /improvements/1
  # DELETE /improvements/1.json
  def destroy
    @improvement.destroy
    respond_to do |format|
      format.html { redirect_to improvements_url, notice: 'Improvement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_improvement
      @improvement = Improvement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def improvement_params
      params.require(:improvement).permit(:topic_id, :area_to_improve, :checked, :user_id, :subject, :subject_id, :topic_name)
    end
end
