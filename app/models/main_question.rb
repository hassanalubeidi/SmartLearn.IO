class MainQuestion < ActiveRecord::Base
	has_many :questions
	has_many :objectives
	belongs_to :test_paper
end
