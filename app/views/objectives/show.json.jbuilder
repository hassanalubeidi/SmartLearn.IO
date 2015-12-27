
json.array! @objective.flashcards do |flashcard|

	json.(flashcard, :top, :id)
	json.topic_id @objective.topic_id
	json.keypoints flashcard.keypoints.each do |keypoint|
		json.extract! keypoint, :text, :id
		json.attempts keypoint.attempts.last(5).each do |attempt|
			json.extract! attempt, :id, :keypoint_id, :user_id, :created_at
			json.time_ago time_ago_in_words(attempt.created_at)
			
		end
	end
end