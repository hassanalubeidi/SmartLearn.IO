class TestPaper < ActiveRecord::Base
  belongs_to :subject
  has_many :questions, :dependent => :destroy

  validates :date, presence: true

  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true
end
