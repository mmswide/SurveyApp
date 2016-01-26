FactoryGirl.define do
  factory :ticket do
    association :event, factory: :event
    ticket_name { Faker::Name.name }
    ticket_description "bla bla bla"
    ticket_price 20
    quantity 20
  end
end