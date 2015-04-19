class Objective < ActiveRecord::Base
  has_many :lines
  has_many :questions, through: :lines, :dependent => :destroy
  has_many :objective_states, :dependent => :destroy
  belongs_to :topic
end
