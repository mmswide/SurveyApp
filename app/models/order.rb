class Order < ActiveRecord::Base
  PROCENT_FEE = 0.025
  CENTS_FEE = 99
  DOLLAR_FEE = 0.99
  STRIPE_PROCENT_FEE = 0.029 
  STRIPE_DOLLAR_FEE = 0.30 

  belongs_to :user
  belongs_to :ticket
  belongs_to :coupon
  belongs_to :event
  has_many :entitlements, foreign_key: :order_id
  has_one :order_transaction, dependent: :destroy
  #attr_accessor for number and cvv because it's prohibited to save that type of data to db
  attr_accessor :card_number, :card_cvv

  accepts_nested_attributes_for :entitlements

  validate :validate_credit_card, on: :create
  validates :buyer_first_name, :buyer_last_name, :address1, :city, :state, 
            :zip, :event_id, presence: true

  after_save :set_money
  #method for performing an actual stripe purchase
  #returns true if payment went successfully
  #also recalculates available tickets that left
  def purchase_order
    response = GATEWAY.purchase(total_price, credit_card, purchase_options)
    create_order_transaction(response: response)
    Ticket.recalculate(entitlements) if response.success?
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
      brand:               card_type,
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
    entitlements.each do |ordered_ticket|
      ticket_price += ordered_ticket.ticket.ticket_price
    end
    raw_price_in_cents = (ticket_price * 100).round 
    fee = (raw_price_in_cents * Order::PROCENT_FEE + Order::CENTS_FEE).round
    raw_price_in_cents -= discount(raw_price_in_cents)
    total_price_in_cents = (raw_price_in_cents + fee).round
    self.update_column(:fee, fee)
    self.update_column(:raw_price, raw_price_in_cents)
    self.update_column(:total_price, total_price_in_cents)
  end

  def discount(cents)
    coupon ? coupon.discount_cents(cents) : 0
  end
end
