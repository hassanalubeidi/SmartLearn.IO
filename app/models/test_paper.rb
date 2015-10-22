class TestPaper < ActiveRecord::Base
  belongs_to :subject
  has_many :questions, :dependent => :destroy
  has_many :main_questions, :dependent => :destroy

  validates :date, presence: true
  validates :subject, presence: true

  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true
  def date_name 
    if self.subject != nil then
  	 return "#{self.subject.name} #{self.date.strftime('%B %Y')}"
    else
      return "No Subject - #{self.date.strftime('%B %Y')}"
    end
  end
  def tots(user)
  	marks = 0
  	tot_marks = 0
  	self.questions.each do |question|
      if question.answer(user) != nil then
        marks += question.answer(user).marks_integer.to_i 
        end
  	end
  	self.questions.each do |question|
  		tot_marks += question.total_marks.to_i
  	end
  	marks = (marks.to_f / tot_marks.to_f ) * 100
  end
end
