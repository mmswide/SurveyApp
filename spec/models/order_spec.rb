require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { is_expected.to have_one(:order_transaction) }
    it { is_expected.to have_many(:entitlements) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:buyer_first_name) }
    it { is_expected.to validate_presence_of(:buyer_last_name) }
    it { is_expected.to validate_presence_of(:address1) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:event_id) }
    it 'validates credit card info on creation' do
      order = Order.new(card_type: 'visa', card_number: nil)
      order.valid?
      expect(order.errors[:base]).not_to include('Number is required')
    end
  end
  describe 'Callbacks' do
    let(:order) { build(:order, raw_price: nil, total_price: nil, fee: nil) }
    it 'saves the raw_price value to the database' do
      order.save
      expect(order.raw_price).to be_present
    end
    it 'saves the total_price value to the database' do
      order.save
      expect(order.total_price).to be_present
    end
    it 'saves the fee value to the database' do
      order.save
      expect(order.fee).to be_present
    end
    it 'saves the right raw_price' do
      raw_price = 0
      order.entitlements.each do |entitlement|
        raw_price += entitlement.ticket.ticket_price
      end
      raw_price_in_cents = raw_price * 100
      order.save
      expect(order.raw_price).to eq(raw_price_in_cents)
    end
    it 'saves the right fee' do
      raw_price = 0
      order.entitlements.each do |entitlement|
        raw_price += entitlement.ticket.ticket_price
      end
      raw_price_in_cents = raw_price * 100
      fee_in_cents = raw_price_in_cents * 0.025 + 99
      order.save
      expect(order.fee).to eq(fee_in_cents)
    end
    it 'saves the right total_price' do
      raw_price = 0
      order.entitlements.each do |entitlement|
        raw_price += entitlement.ticket.ticket_price
      end
      raw_price_in_cents = raw_price * 100
      fee_in_cents = raw_price_in_cents * 0.025 + 99
      total_price_in_cents = raw_price_in_cents + fee_in_cents
      order.save
      expect(order.total_price).to eq(total_price_in_cents)
    end
  end
  describe 'purchase_order' do
    let(:order) { create(:order) }
    let(:invalid_order) { create(:order_with_unvalid_card) }
    it 'is success with valid data' do
      expect(order.purchase_order).to be_truthy
    end
    it 'fails with unvalid data' do
      expect(invalid_order.purchase_order).to be_falsy
    end
    it 'creates order transaction'
    context 'order_transaction' do
      it 'sets field :success to true if transaction was successfull'
      it 'sets field :success to false if transaction failed'
      it 'assigns the field :message with successful message if transaction was successfull'
      it 'assigns the field :message with error message if transaction failed'
    end
    it 'recalculates tickets if transaction was successfull'
    it 'does not recalculates tickets if transaction failed'
  end
end
