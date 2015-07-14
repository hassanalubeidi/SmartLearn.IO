class Flashcard < ActiveRecord::Base
	belongs_to :objective
	has_many :keypoints
	
end
