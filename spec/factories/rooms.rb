FactoryGirl.define do 
  factory :room do
    name { Faker::Company.name }
  end
end