class ManagedAccountsController < ApplicationController 
  include ManagedAccountsHelper

  def new
    @countries = {"US":"United States", "CA":"Canada", "GB":"United Kindom", "FR":"France"}
    @currencies = {"USD":"US Doller", "CAD":"Canada Doller", "GBP":"Pound", "EUR":"Euro"}
    @account_holder_types = {"individual":"Individual", "company":"Company"}
  end
  
  def create
    connector = StripeManaged.new( current_user )
    account = connector.create_account!(
        "US", true, request.remote_ip, managed_account_params
      )
    byebug
    begin
      Stripe::Transfer.create(
        {
          :amount => 1000,
          :currency => "usd",
          :destination => 'Example Charge',
          :application_fee => 123
        },
        {:stripe_account => account.id}
      )
    rescue => e
      @error = e.message
      nil
    end
    byebug
    redirect_to current_user
  end

  def edit
  end

  def update
    byebug
    update_stripe_managed_account(current_user, managed_account_params)
  end
private
  def managed_account_params
    params.permit(:bank_account_token, :legal_entity => [{:dob => [:month, :day, :year]}, :first_name, :last_name, :type, {:address => [:city, :line1, :postal_code, :state]}, :ssn_last_4])
  end
end