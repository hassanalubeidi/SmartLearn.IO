class MainQuestion < ActiveRecord::Base
	has_many :questions
	has_many :objectives
end
