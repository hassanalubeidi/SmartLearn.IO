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

	private
	def time_degredation(question)
		a = (Time.now -  question.answers.where(:user => current_user).last.created_at).to_i / 86400
		if a < 10 then return 1
		elsif a < 30 then return 0.8
		elsif a < 50 then return 0.5
		else return 0.2
		end
	end
end
