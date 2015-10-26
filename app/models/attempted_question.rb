class AttemptedQuestion < ActiveRecord::Base
	belongs_to :objective
	belongs_to :user
	has_one :question
end
