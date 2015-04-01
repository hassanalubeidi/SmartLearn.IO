module SubjectsHelper
	def marks(question)
		return "#{question.answers.where(:user => current_user).last.marks_integer}/#{question.total_marks}"
	end 
	def progress_in_topic(topic)
		marks = 0
		total_marks = 0
		topic.questions.where(topic: topic).each do |question|
			marks += question.answers.where(:user => current_user).last.marks_integer.to_i * time_degredation(question)
			total_marks += question.total_marks
		end
		return (marks.to_f / total_marks.to_f) * 100
	end

	def progress_in_objective(objective)
		marks = 0
		total_marks = 0
		objective.questions.each do |question|
			marks += question.latest_mark * time_degredation(question)
			total_marks += question.total_marks
		end
		return (marks.to_f / total_marks.to_f) * 100
	end

	private
	def time_degredation(question)
		a = (Time.now -  question.answers.where(:user => current_user).last.created_at).to_i / 86400
		return half_life(question.created_at) ** -(a) # exponentail graph
	end
	def half_life(date)
		case date.strftime("%B")
		when "September", "October" , "November" , "December"
			return 1.02337 #30 day half life - learning process
		when "January" , "February"
			return 1.01748 #40 day half life - applying knowlege from previous terms
		when "March"
			return 1.01369 #50 day half life - almost finished learning, started revising
		when "April" , "May" , "June"
			return 1.00995 #70 day - completely finished learning, just revising
		end


	end	
end
