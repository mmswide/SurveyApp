FactoryGirl.define do
  factory :entitlement do
    association :ticket, factory: :ticket
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email "example@mail.com"
  end
end