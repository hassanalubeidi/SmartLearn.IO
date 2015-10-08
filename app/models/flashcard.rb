class Flashcard < ActiveRecord::Base
	belongs_to :objective
	has_many :keypoints
	accepts_nested_attributes_for :keypoints, :reject_if => :all_blank, :allow_destroy => true
	def get_top
		if self.top == nil then
			return self.text 
		else
			return self.top
		end 
	end
	def last_attempted(user)
		lasts = []
		self.keypoints.each do |keypoint|
			x = keypoint.attempts.where(user: user).last 
			unless x == nil then lasts.push(Attempt.where(user: user, keypoint: keypoint).last.created_at) end
		end
		return lasts.max || nil
		
	end
	def state(user)
		correct_keypoints = []
		self.keypoints.each do |keypoint|
			unless keypoint.attempts.count == 0 then
				if keypoint.attempts.where(user: user).last.correct == true then
					correct_keypoints.push(keypoint)
				end
			end
		end

		if correct_keypoints.count == keypoints.count then
			return "not fluent"
		elsif correct_keypoints.count > 0 then
			return "partial"
		else
			return "none"
		end
	end
end
