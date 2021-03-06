class ImprovementsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)

  before_action :set_improvement, only: [:show, :edit, :update, :destroy, :add_review]
  skip_before_filter :verify_authenticity_token  

  # GET /improvements
  # GET /improvements.json
  def index
    @improvements = current_user.improvements
  end
  def add_review
    Review.create :user => current_user, :improvement => @improvement
    redirect_to improvements_path, notice: 'Improvement was successfully created.'
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
    @improvement.user = current_user unless current_user == nil

    respond_to do |format|
      if @improvement.save
        format.html { 

            redirect_to improvements_path, :flash => { :success => "Improvement was successfully created." }

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
      params.require(:improvement).permit(:topic_id, :area_to_improve, :checked, :user_id, :subject, :subject_id, :topic_name, :flashcard_id)
    end
end
