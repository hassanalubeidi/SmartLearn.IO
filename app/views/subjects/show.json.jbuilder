json.subject @subject
json.array! @subject.topics.each do |topic|
	json.topic topic
	json.array! topic.objectives.each do |objective|
		json.objective objective
	end
end