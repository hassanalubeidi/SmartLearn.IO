class MainQuestion < ActiveRecord::Base
	has_many :questions
	has_and_belongs_to_many :objectives
	belongs_to :test_paper
end
