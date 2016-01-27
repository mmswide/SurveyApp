FactoryGirl.define do
  factory :event do
    association :user, factory: :user
    event_name { Faker::Company.name }
    sequence(:event_url) { |n| "bububu#{n}" }
    description_short 'Bla bla bla'
  end
end