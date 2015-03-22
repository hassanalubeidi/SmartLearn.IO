class Topic < ActiveRecord::Base
  belongs_to :subject
  belongs_to :module_pack
  has_many :improvements
  has_many :questions

  validates :name, presence: true
end
