json.name @test_paper.name
json.subject @test_paper.subject.name
json.mainquestions @test_paper.main_questions.each do |mainquestion|
	json.questions mainquestion.questions.each do |question|
		json.position question.position
		json.html question.html.gsub(/width/, "max-width").gsub(/Q1\./, "")
		json.total_marks question.total_marks
		json.id question.id
		json.answer do |answer|
			if question.answers.last != nil then
				json.marks question.answers.last.marks_integer
				json.what_went_wrong question.answers.last.text
                json.what_went_wrong_image_url question.answers.last.picture.url unless question.answers.last.picture.url.blank?
			else
				json.no_answer true
			end
		end
		if !question.answers.blank?
			json.answered !question.answers.blank?
		end
	end
	json.id mainquestion.id
	json.answer_html mainquestion.answer_html.gsub(/\/\/W3C\/\/DTD HTML 4.01 Transitional\/\/EN\"\"\>/m, "")
end
