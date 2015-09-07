FactoryGirl.define do 
	factory :question do 
		text	"a question"
		total_marks	10
		test_paper

		factory :question_with_topics do
	    	after(:build) do |question|
	    		create_list(:answer, 5, question: question)
	    	end
	    end
	end
end