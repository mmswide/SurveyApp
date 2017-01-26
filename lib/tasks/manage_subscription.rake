namespace :manage_subscription do
  desc "TODO"
  task create_packages: :environment do
    Stripe::Plan.create(
      :amount => 150 *100,
      :interval => 'month',
      :name => 'plan_1',
      :currency => 'usd',
      :trial_plan => nil,
      :id => SecureRandom.uuid # This ensures that the plan is unique in stripe
    )
  end
end
