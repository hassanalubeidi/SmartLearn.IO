class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_and_belongs_to_many :interventions

  has_attached_file :picture
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
end
