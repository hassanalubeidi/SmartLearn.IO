class Improvement < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  validates :topic, presence: true
  validates :area_to_improve, presence: true
end
