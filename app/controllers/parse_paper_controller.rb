class ParsePaperController < ApplicationController
	def index
		@paper = params[:paper]
	end
	def create
		paper = ParsePaper::parse(params[:url])
		paper = JSON.parse(paper)
		testpaper = TestPaper.last
		paper["mainquestions"].each do |mainquestion|
			topic_name = mainquestion["objectives"][0][1]["label"]
			topic = Topic.find_or_create_by(name: topic_name, subject_id: testpaper.subject.id)
			objective_name = mainquestion["objectives"][0][2]["label"]
			objective = Objective.find_or_create_by(name: objective_name, topic_id: topic.id)
			m = MainQuestion.new(html: mainquestion["html"])
			m.objectives << objective
			mainquestion["questions"].each do |question|

				q = Question.create(position: question["position"], total_marks: question["total_marks"])

				m.questions << q
			end
			m.save
			testpaper.main_questions << m
		end
		testpaper.save
		redirect_to test_paper_path(testpaper.id)
	end
	def new

	end
end
