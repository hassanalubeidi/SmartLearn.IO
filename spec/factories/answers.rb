FactoryGirl.define do 
	factory :answers do
		question
		user
		text	""
		marks_integer 6

	end
end