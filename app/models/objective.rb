class Objective < ActiveRecord::Base
  has_many :lines
  has_many :questions, through: :lines
  has_many :objective_states
  belongs_to :topic
end
