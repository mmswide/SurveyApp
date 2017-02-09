module ManagedAccountsHelper
  def options_for_select(json_data)
    options = ""
    json_data.each do |key, value|
      options+="<option value='#{key}'>#{value}</option>"
    end
    return options.html_safe    
  end

  def create_stripe_managed_account(user)
    connector = StripeManaged.new(user)
    account = connector.create_account!(
        "US", true, request.remote_ip
    )
  end

  def update_stripe_managed_account(user, params)
    manager = StripeManaged.new(user)
    manager.update_account! params: params
  end
end