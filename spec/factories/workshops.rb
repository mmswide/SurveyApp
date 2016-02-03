FactoryGirl.define do 
  factory :workshop do
    title { Faker::Company.name }
    time Time.now
    instructor "Bla"
    level "Middle"
    location "Upper"
    category "Home"
  end
end