class Improvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :topic
  has_many :reviews
  belongs_to :flashcard

  validates :area_to_improve, presence: true


  
  def topic_name=(name)
  	self.topic = Topic.find_or_create_by(name: name.capitalize) unless name.blank?
  end
  def topic_name
  	topic.try(:name)
  end
  def subject
  	self.topic.subject unless self.topic.subject.blank?
  end
end
