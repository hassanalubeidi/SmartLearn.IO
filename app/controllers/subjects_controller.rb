class SubjectsController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy, :index, :make_chemistry]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @attempted_questions = AttemptedQuestion.where(subject: @subject)
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)
    @subject.user = current_user
    respond_to do |format|
      if @subject.save
        format.html { redirect_to new_subject_topic_path(@subject), notice: 'Subject was successfully created, create new topics?' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def make_chemistry
    # topics = [
    # {"unit":["1.1 Module 1: Atoms and Reactions"], "chapters":[["1.1.1 Atoms"], ["1.1.2 Moles and equations"], ["1.1.3 Acids"], ["1.1.4 Redox"]]},
    # {"unit":["1.2 Module 2: Electrons, Bonding and Structure"], "chapters":[["1.2.1 Electron structure"], ["1.2.2 Bonding and structure"]]},
    # {"unit":["1.3 Module 3: The Periodic Table"], "chapters":[["1.3.1 Periodicity"], ["1.3.2 Group 2"], ["1.3.3 Group 7"]]},
    # {"unit":["2.1 Module 1: Basic Concepts and Hydrocarbons"], "chapters":[["2.1.1 Basic Concepts"], ["2.1.2 Alkanes"], ["2.1.3 Alkenes"]]},
    # {"unit":["2.2 Module 2: Alcohols, Halogenoalkanes and Analysis"], "chapters":[["2.2.1 Alcohols"], ["2.2.2 Halogenoalkanes"], ["2.2.3 Modern Analytical Techniques"]]},
    # {"unit":["2.3 Module 3: Energy"], "chapters":[["2.3.1 Enthalpy Changes"], ["2.3.2 Rates and Equilibrium"]]},
    # {"unit":["2.4 Module 4: Resources"], "chapters":[["2.4.1 Chemistry of the Air"], ["2.4.2 Green Chemistry"]]},
    # {"unit":["4.1 Module 1: Rings, Acids and Amines"], "chapters":[["4.1.1 Arenes"], ["4.1.2 Carbonyl Compounds"], ["4.1.3 Carboxylic Acids and Esters"], ["4.1.4 Amines"]]},
    # {"unit":["4.2 Module 2: Polymers and Synthesis"], "chapters":[["4.2.1 Amino Acids and Proteins"], ["4.2.2 Polyesters and Polyamides"], ["4.2.3 Synthesis"]]},
    # {"unit":["4.3 Module 3: Analysis"], "chapters":[["4.3.1 Chromatography"], ["4.3.2 Spectroscopy"]]},
    # {"unit":["5.1 Module 1: Rates, Equilibrium and pH"], "chapters":[["5.1.1 How Fast?"], ["5.1.2 How Far?"], ["5.1.3 Acids, Bases and Buffers"]]},
    # {"unit":["5.2 Module 2: Energy"], "chapters":[["5.2.1 Lattice Enthalpy"], ["5.2.2 Enthalpy and Entropy"], ["5.2.3 Electrode Potentials and Fuel Cells"]]},
    # {"unit":["5.3 Module 3: Transition Elements"], "chapters":[["5.3.1 Transition Elements"]]}
    # ]
    # topics.each do |topic|
    #   t = Topic.create(name: topic["unit"].join, subject_id: 3)
    #   topic["chapters"].each do |chapter|
    #     Objective.create(topic_id: t.id, name: chapter.join)
    #   end
    # end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params[:subject].permit(:name, :user_id, :user)
    end
end
