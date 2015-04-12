class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers
  belongs_to :test_paper
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :lines
  accepts_nested_attributes_for :lines
  has_many :objectives, through: :lines

end
