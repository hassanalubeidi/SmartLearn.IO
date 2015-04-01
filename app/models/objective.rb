class Objective < ActiveRecord::Base
  has_many :lines
  has_many :questions, through: :lines
end
