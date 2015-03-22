class Improvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :topic
  has_many :reviews

  validates :topic, presence: true
  validates :area_to_improve, presence: true
end
