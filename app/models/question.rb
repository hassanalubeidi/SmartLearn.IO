class Question < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :main_question
  has_many :answers, :dependent => :destroy
  has_many :attempted_questions, :dependent => :destroy
  belongs_to :test_paper
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :lines
  accepts_nested_attributes_for :lines
  has_many :objectives, through: :lines

  	def similar_questions
	    []
	end
	def sim_ques(user)
		matches = []
		objectives = self.objectives
		all_main_questions = MainQuestion.all
		all_main_questions.each do |mq|
			questions_objs = mq.objectives
			if questions_objs == objectives and mq.id != self.main_question.id and mq.questions.first.answer(user) == nil then
				matches.push [mq, objectives.uniq.count]
			end
		end
		if matches.count == 0 then
			all_main_questions.each do |mq|
				if objectives.to_set.intersect?(mq.objectives.to_set) == true and mq.id != self.main_question.id and mq.questions.first.answer(user) == nil then
					matches.push [mq, objectives.to_set.intersection(mq.objectives.to_set).count]
				end
			end
		end
		return matches.sort_by!{ |m| m[1] }.reverse

	end
	def source
		mq = self.main_question
		exampro_id = mq.exampro_id
		year = exampro_id.split(".")[0].match(/[1-9][1-9]/)
		month = exampro_id.split(".")[0][3]
		if month = "W" then
			month =  "January"
		elsif month = "S" then
			month = "June"
		end
		return "#{month} 20#{year}, Question #{exampro_id.split(".")[0][2]}#{self.position}"
	end
	def expected(user)
		total = []
		mean = 0
		self.objectives.each do |obj|
			total.push(obj.progress(user))
		end
		total.each do |x|
			mean += x
		end
		mean = mean / total.count
		return mean
	end
	def answer(user)
		unless self.answers.count == 0 then
			return @answer if defined? @answer
    		@answer = self.answers.where(user: user).last
    		return @answer
		else return nil
		end
	end
	def difficulty(user)
		diffs = 0
		count = 0
		self.objectives.each do |obj|
			diffs += obj.difficulty(user).to_f
			count += 1
		end
		return diffs / count #mean of the diffuculties
	end
	def get_marks_percentage(user)
		if self.answers.where(:user => user).last != nil then
			self.answers.where(:user => user).last.marks_integer.to_f / self.total_marks.to_f
		else return 1
		end
	end
	def objectives
	    return @objectives if defined? @objectives
    	@objectives = self.main_question.objectives
	end


	private 
	def get_objectives
		self.main_question.objectives
	end
end
