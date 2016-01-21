class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  has_many :order_transactions

  attr_accessor :card_number, :card_cvv

  validate_on_create :validate_credit_card


  def validate_credit_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

  def self.purchase_order(params, user)
    ticket = Ticket.find_by(id: params[:ticket_id])
    price_in_cents = get_price(params)
    credit_card = credit_card(params)
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    response.success?
    raise response.inspect
  end

  def self.get_price(params)
    ticket = Ticket.find_by(id: params[:ticket_id])
    price = (ticket.ticket_price * params[:ticket_amount].to_i * 100).round
  end

  def self.purchase_options
    purchase_options = { billing_address: {
      name:      "Customer Name",
      address1:  "Customer Address Line 1",
      city:      "Customer City",
      state:     "Customer State",
      zip:       "Customer Zip Code"
    }}
  end

  def credit_card(params)
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      type:                params[:card_type],
      number:              params[:card_number],
      verification_value:  params[:card_cvv],
      month:               params[:card_expires_month],
      year:                params[:card_expires_year],
      first_name:          params[:first_name],
      last_name:           params[:last_name]
    )
  end
end
