class Subject < ActiveRecord::Base
	belongs_to :user
	has_many :improvements, :dependent => :destroy
	has_many :topics, :dependent => :destroy
	has_many :test_papers

	validates :name, presence: true
end
