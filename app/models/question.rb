class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers
  belongs_to :test_paper

  has_many :lines
  accepts_nested_attributes_for :lines
  has_many :objectives, through: :lines

end
