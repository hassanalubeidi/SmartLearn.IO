
FactoryGirl.define do
  # user factory without associated subjects
  factory :subject do
    name "Chemistry"
    user

    factory :subject_with_topics do
    	after(:build) do |subject|
    		create_list(:topic, 5, subject: subject)
    	end
    end

    
  end
end