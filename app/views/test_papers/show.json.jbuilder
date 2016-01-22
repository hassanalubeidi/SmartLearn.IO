json.name @test_paper.name
json.subject @test_paper.subject.name
json.mainquestions @test_paper.main_questions.each do |mainquestion|
	json.questions mainquestion.questions.each do |question|
		json.position question.position
		json.html question.html
		json.total_marks question.total_marks
		json.answer do |answer|
			if question.answers.last != nil then
				json.marks question.answers.last.marks_integer
				json.what_went_wrong question.answers.last.text
			else
				json.no_answer true
			end
		end
		if !question.answers.blank?
			json.answered !question.answers.blank?
		end
	end
end
