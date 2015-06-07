class Topic < ActiveRecord::Base
  belongs_to :subject
  belongs_to :module_pack
  has_many :improvements, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :objectives, :dependent => :destroy

  accepts_nested_attributes_for :objectives, :reject_if => :all_blank, :allow_destroy => true

  validates :name, presence: true

    def progress(user)
		unless get_questions_of_topic.count == 0 then #fix for topics that dont have questions returning nil rather than 0.00
			marks = 0
			total_marks = 0
			topic.unique_questions.each do |question|
				unless question.answers.where(:user => user).blank?
					marks += question.answers.where(:user => user).last.marks_integer.to_i * time_degredation(question, user)
					total_marks += question.total_marks
				end
			end
			return (marks.to_f / total_marks.to_f) * 100
		else
			return 0
		end
	end
	private

	def unique_questions
		questionss = []
		@topic.objectives.each do |objective|
			objective.questions.each do |question|
				questionss.push(question)
			end
		end

		questionss.uniq
	end	
	def time_degredation(question, user)
		a = (Time.now -  question.answers.where(:user => user).last.created_at).to_i / 86400
		return half_life(user, question) ** -(a) # exponentail graph
	end
	def half_life(user, question) # a much more dynamic half life. NOT FINISHED NEEDS TO GET QUESTION.OBJECTIVES.QUESTIONS.COUNT
		d = question.diffuculty
		x = question.similar_questions.count
		a = 100 #no of iterations till...
		b = 10 #.. x10 default

		return half_life_decay(d * (half_life_growth(a,b) ** x))  #very powerful
	end
	def half_life_decay(steps)
		return 0.5 ** (-1 / steps )
	end
	def half_life_growth(steps,max)
		return max ** (1 / steps)
	end
end
