class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers, :dependent => :destroy
  belongs_to :test_paper
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :lines
  accepts_nested_attributes_for :lines
  has_many :objectives, through: :lines
  def similar_questions
	    quess = []
		self.objectives.each do |obj|
			obj.questions.each do |ques|
				quess.push(ques)
			end
		end
		return quess
	end
	def answer(user)
		unless self.answers.count == 0 then
			return self.answers.where(user: user).last
		else return nil
		end
	end
	def difficulty(user)
		diffs = 0
		count = 0
		self.objectives.each do |obj|
			diffs += obj.difficulty(user).to_f
			count += 1
		end
		return diffs / count #mean of the diffuculties
	end
	def foo
		"bar"
	end
end
