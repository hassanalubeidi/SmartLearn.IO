class Objective < ActiveRecord::Base
  has_many :lines
  has_many :questions, through: :lines
  has_many :objective_states
  belongs_to :topic


  def progress(user) #usually user = current_user
		marks = 0
		total_marks = 0
		@objective.questions.each do |question|
			unless question.answers.where(:user => user).count == 0 then 
				marks += question.answer.marks_integer.to_i * time_degredation(question, user)
				total_marks += question.total_marks
			end
		end
		return (marks.to_f / total_marks.to_f) * 100
	end
	def diffuculty(user)
		if user.grade == "A*" or user.grade == "A" then
			@objective.easier_diffuculty
		else 
			@objective.harder_diffuculty
		end
	end
	def colour(user)
		if @objective.progress(user) < 50 then
			return "red"
		elsif @objective.progress(user) < 81
			return "yellow"
		elsif @objective.progress(user) > 81
			return "green"
		end
	end
	private

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
