module TestPapersHelper
	def total_marks(test_paper)
		all_marks = 0
		test_paper.questions.each do |question|
			ans = question.answers.where(:user => current_user).last.marks_integer
			all_marks += ans
		end
		return all_marks
	end
end
