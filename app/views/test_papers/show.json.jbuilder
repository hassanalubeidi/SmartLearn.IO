json.name @test_paper.name
json.subject @test_paper.subject.name
json.mainquestions @test_paper.main_questions.each do |mainquestion|
	json.questions mainquestion.questions.each do |question|
		json.position question.position.gsub(/1/, "")
		unless question.html == nil
			json.html question.html.gsub(/width/, "max-width").gsub(/Q1\./, "")
		end
		json.total_marks question.total_marks
		json.id question.id
		json.answer do |answer|
			if question.answer(current_user) != nil then
				json.marks question.answer(current_user).marks_integer
				json.what_went_wrong question.answer(current_user).text
                json.what_went_wrong_image_url question.answer(current_user).picture.url unless question.answer(current_user).picture.url.blank?
			else
				json.no_answer true
			end
		end
		if !question.answers.blank?
			json.answered !question.answer(current_user).blank?
		end
	end
	json.id mainquestion.id
	unless mainquestion.answer_html == nil then
		json.answer_html mainquestion.answer_html.gsub(/\/\/W3C\/\/DTD HTML 4.01 Transitional\/\/EN\"\"\>/m, "")
	end
end