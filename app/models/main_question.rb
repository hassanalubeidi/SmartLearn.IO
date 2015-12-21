class MainQuestion < ActiveRecord::Base
	has_many :questions, dependent: :destroy
	has_and_belongs_to_many :objectives
	has_and_belongs_to_many :test_papers

	def source
		exampro_id = self.exampro_id
		year = exampro_id.split(".")[0].match(/[0-9][0-9]/)
		month = exampro_id.split(".")[0][3]
		if month = "W" then
			month =  "January"
		elsif month = "S" then
			month = "June"
		end
		return "#{exampro_id.split(".")[1]} #{month} 20#{year}, Question #{exampro_id.split(".")[2]}"
	end
	def answered?(user)
		if self.questions.first.answer(user) != nil then
			return true
		else
			return false
		end
	end
end
