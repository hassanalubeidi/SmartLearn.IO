class Objective < ActiveRecord::Base
  has_many :lines
  has_many :questions, through: :lines
  has_many :objective_states
  has_many :flashcards
  accepts_nested_attributes_for :flashcards, :reject_if => :all_blank, :allow_destroy => true
  belongs_to :topic


  def progress(user) #usually user = current_user
		marks = 0
		total_marks = 0
		self.questions.each do |question|
			unless question.answers.where(:user => user).count == 0 then 
				marks += question.answer(user).marks_integer.to_i * time_degredation(question, user)
				total_marks += question.total_marks
			end
		end
		return (marks.to_f / total_marks.to_f) * 100 #might give an error if an objective has no question?
	end
	def difficulty(user)
		if user.grade == "A*" or user.grade == "A" then
			self.easier_difficulty
		else 
			self.harder_difficulty
		end
	end
	def colour(user)
		if self.progress(user) < 50 then
			return "red"
		elsif self.progress(user) < 81
			return "yellow"
		elsif self.progress(user) > 81
			return "green"
		else 
			return ""
		end
	end
	private

	def time_degredation(question, user)
		a = (Time.now -  question.answers.where(:user => user).last.created_at).to_i / 86400
		return half_life(user, question) ** -(a) # exponentail graph
	end
	def half_life(user, question) # a much more dynamic half life. NOT FINISHED NEEDS TO GET QUESTION.OBJECTIVES.QUESTIONS.COUNT
		d = question.difficulty(user)
		x = question.similar_questions.count
		a = 100 #no of iterations till...
		b = 10 #.. x10 default

		return half_life_decay(d * (half_life_growth(a,b) ** x))  #very powerful
	end
	def half_life_decay(steps)
		return 0.5 ** (-1 / steps.to_f )
	end
	def half_life_growth(steps,max)
		return max ** (1 / steps.to_f )
	end
end
