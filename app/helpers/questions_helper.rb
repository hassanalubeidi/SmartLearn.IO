module QuestionsHelper
	def total_marks_percentage
		return (marks.to_f / @question.total_marks.to_f)*100
	end
end
