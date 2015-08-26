class TestPapersController < ApplicationController
  require 'ParsePapers'
  before_action :set_test_paper, only: [:show, :edit, :update, :destroy]

  def index
    @test_papers = TestPaper.all
  end

  def upload
    
  end
  def parse
    url = params[:test_paper_url]
    
    t = number_of_questions(url)
    (1..t).each do |q_num|
       q = ParsePapers::Question.new(q_num, url)
       Question.create(html: q.question_html,
                       mark_scheme_html: q.answer_html,
                       exam_notes_html: q.exam_notes_html,
                       source: q.source,
                       topic: Topic.find_or_create_by(name: q.topic),
                       description: q.description,
                       total_marks: q.marks)
     end
    redirect_to test_papers_upload_show_path
    
  end
  def show_uploaded
    @questions = Question.last(3)
  end
  def show
  end

  def new
    @test_paper = TestPaper.new
    @question = Question.new
  end

  def edit
  end

  def create
    @test_paper = TestPaper.new(test_paper_params)
    @test_paper.save
    redirect_to :back
  end

  def update
    @test_paper.update(test_paper_params)
    redirect_to @test_paper
  end

  def destroy
    @test_paper.destroy
    redirect_to :back
  end

  private
    def set_test_paper
      @test_paper = TestPaper.find(params[:id])
    end

    def test_paper_params
      params.require(:test_paper).permit(:subject_id,:name , :test_paper_url, :html, :mark_scheme_html, :source, :exam_notes_html, :description,  :questions, :date, :calc_allowed, :url, questions_attributes: [:text, :attachment, :total_marks, lines_attributes: [ :id, :question_id, :objective_id, :_destroy ]])
    end

    def number_of_questions(url)
      g = 0
      test = []
      objects = []
      page = Nokogiri::HTML(open(url))
      page.css("table").each_with_index do |object, index|
        if is_start_of(object)  then
          objects.push index
        end
      end
      return objects.count
    end

    def is_start_of(table)
      type = "question"
      unless table.css("b") == nil then
        a = table.css("b").to_a
        objects = []
        a.each do |x|
          if /#{parse_type(type)}[1-9]/.match(x.content) != nil then 
            objects.push(x)
          end
        end
        if objects.count > 0 then
         return true
        else return false
        end
      else
        return false
      end
    end

    def parse_type(type)
      case type
      when "question", "a question", "questions"
        type = "Q"
      when "marking" , "answer" , "markings" , "answers"
        type = "M"
      when "exam note", "exam notes" , "exam_note"
        type = "E"
      when "note" , "info"
        type = "N"
      else 
        raise "invalid type in parse_types"
      end
      return type
    end 

end
