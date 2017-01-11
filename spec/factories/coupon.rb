FactoryGirl.define do
  factory :coupon do
    quantity            30
    active              true
    discount_type       'percents'
    discount_percentage 30
    expiration          "2030-01-16"
  end
end