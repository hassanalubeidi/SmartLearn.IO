module TestPapersHelper
	def total_marks(test_paper)
		all_marks = 0
		test_paper.questions.each do |question|
			if question.answers.where(question: question, user: current_user).count != 0 then
				ans = question.answers.where(:user => current_user).last.marks_integer.to_i
			else
				ans = 0
			end
			all_marks += ans
		end
		return all_marks
	end
end
