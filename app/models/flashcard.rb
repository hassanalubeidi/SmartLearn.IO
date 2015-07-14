class Flashcard < ActiveRecord::Base
	belongs_to :objective
	has_many :keypoints
	accepts_nested_attributes_for :keypoints, :reject_if => :all_blank, :allow_destroy => true
	
end
