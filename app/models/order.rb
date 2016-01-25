class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  has_many :order_tickets, foreign_key: :order_id
  has_many :order_transactions
  #attr_accessor for number and cvv because it's prohibited to save that type of data to db
  attr_accessor :card_number, :card_cvv

  accepts_nested_attributes_for :order_tickets

  validate :validate_credit_card, on: :create
  validates :buyer_first_name, :buyer_last_name, :address1, :city, :state, 
            :zip, presence: true

  after_save :set_money
  #method for performing an actual stripe purchase
  #returns true if payment went successfully
  #also recalculates available tickets that left
  def purchase_order
    response = GATEWAY.purchase(total_price, credit_card, purchase_options)
    order_transactions.create!(response: response)
    Ticket.recalculate(order_tickets) if response.success?
    response.success?
  end

  private 

  def purchase_options
    @purchase_options = { 
      ip: ip_address,
      billing_address: {
        name:      "#{buyer_first_name} #{buyer_last_name}",
        address1:  address1,
        city:      city,
        state:     state,
        zip:       zip
    }}
  end

  def validate_credit_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      type:                card_type,
      number:              card_number,
      verification_value:  card_cvv,
      month:               card_expires_month,
      year:                card_expires_year,
      first_name:          buyer_first_name,
      last_name:           buyer_last_name
    )
  end
  #method for calculating price for future purchase
  #updates :fee, :raw_price and :total_price fields in order table
  #returns nothing
  def set_money
    ticket_price = 0
    order_tickets.each do |ordered_ticket|
      ticket_price += ordered_ticket.ticket.ticket_price
    end
    raw_price_in_cents = (ticket_price * 100).round
    fee = (raw_price_in_cents * 0.025 + 99).round
    total_price_in_cents = (raw_price_in_cents + fee).round
    self.update_column(:fee, fee)
    self.update_column(:raw_price, raw_price_in_cents)
    self.update_column(:total_price, total_price_in_cents)
  end
end
