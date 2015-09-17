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
			x = Attempt.where(user: user, keypoint: keypoint).last 
			unless x == nil then lasts.push(Attempt.where(user: user, keypoint: keypoint).last.created_at) end
		end
		return lasts.max || nil
		
	end
end
