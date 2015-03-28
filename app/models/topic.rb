class Topic < ActiveRecord::Base
  belongs_to :subject
  belongs_to :module_pack
  has_many :improvements, :dependent => :destroy
  has_many :questions, :dependent => :destroy

  validates :name, presence: true


end
