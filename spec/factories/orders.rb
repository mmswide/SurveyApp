FactoryGirl.define do
  factory :order do
    association :user, factory: :user
    association :event, factory: :event
    buyer_first_name { Faker::Name.first_name }
    buyer_last_name { Faker::Name.last_name }
    card_expires_year Time.now.year
    card_expires_month Date.today.month
    card_type "visa"
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    raw_price 200
    fee (200*0.025 + 1)
    total_price 200 + (200*0.025 + 1)
    ip_address '127.0.0.1'
    card_number 4111111111111111
    card_cvv 322
    factory :order_with_unvalid_card do
      card_number 4242424242424242
      card_cvv 322
    end
    after(:build) do |order|
      entitlement1 = build(:entitlement) 
      entitlement2 = build(:entitlement) 
      order.entitlements = [entitlement1, entitlement2]
    end
  end
end