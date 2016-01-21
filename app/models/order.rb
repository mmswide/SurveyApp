class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  has_many :order_tickets, foreign_key: :order_id
  has_many :order_transactions

  attr_accessor :card_number, :card_cvv
  accepts_nested_attributes_for :order_tickets, reject_if: :all_blank, allow_destroy: true 

  validate :validate_credit_card, on: :create
  validates :buyer_first_name, :buyer_last_name, :address1, :city, :state, :zip, presence: true

  after_save :set_money

  def purchase_order
    response = GATEWAY.purchase(total_price, credit_card, purchase_options)
    order_transactions.create!(response: response)
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

  def validate_credit_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end

  def set_money
    ticket = Ticket.find_by(id: order_tickets.first.ticket_id)
    raw_price_in_cents = (ticket.ticket_price * ticket_amount * 100).round
    fee = (raw_price_in_cents * 0.025 + 99).round
    total_price_in_cents = (raw_price_in_cents + fee).round
    self.update_column(:fee, fee)
    self.update_column(:raw_price, raw_price_in_cents)
    self.update_column(:total_price, total_price_in_cents)
  end
end
