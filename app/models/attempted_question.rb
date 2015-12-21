class AttemptedQuestion < ActiveRecord::Base
	belongs_to :subject
	belongs_to :topic
	belongs_to :objective
	belongs_to :user
	belongs_to :question
	belongs_to :answer
end
