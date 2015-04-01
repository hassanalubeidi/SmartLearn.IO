class Topic < ActiveRecord::Base
  belongs_to :subject
  belongs_to :module_pack
  has_many :improvements, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :objectives, :dependent => :destroy

  accepts_nested_attributes_for :objectives, :reject_if => :all_blank, :allow_destroy => true

  validates :name, presence: true


end
