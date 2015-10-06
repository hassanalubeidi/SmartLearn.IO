class Subject < ActiveRecord::Base
	belongs_to :user
	has_many :improvements, :dependent => :destroy
	has_many :topics, :dependent => :destroy
	has_many :test_papers

	validates :name, presence: true
	def progress(user)
		if self.topics.count != 0 then
			tot = 0
			self.topics.each do |t|
				tot = 0
				tot += t.progress(user).to_f
			end
			return tot / self.topics.count
		else
			return nil
		end
	end
	def all_objectives
		objectives = []
		self.topics.each do |t|
			t.objectives.each do |o|
				objectives.push(o)
			end
		end
		return objectives
	end
end
