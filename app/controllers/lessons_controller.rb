class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = Lesson.all
  end

  def show
    
  end

  def new
    @lesson = Lesson.new
    
  end

  def edit
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.save
    
  end

  def update
    @lesson.update(lesson_params)
    
  end

  def destroy
    @lesson.destroy
    
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:date, :subject_id, :title, :powerpoint)
    end
end
