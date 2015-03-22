class Subject < ActiveRecord::Base
	belongs_to :user
	has_many :improvements
	has_many :topics

	validates :name, presence: true
end
