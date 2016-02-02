FactoryGirl.define do
  factory :day do
    association :event, factory: :event
    name { Faker::Name.first_name }
    date Date.today
  end
end