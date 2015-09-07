
FactoryGirl.define do
  # user factory without associated subjects
  factory :user do
    email 'tests@example.com'
    password 'f4k3p455w0rd'

    factory :user_with_subjects do

      email	'test2s@example.com'

      transient do
        subjects_count 5
      end

      after(:build) do |user|
        FactoryGirl.create_list(:subject, 5, user: user)
      end

    end
  end
end