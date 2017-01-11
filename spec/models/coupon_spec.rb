require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { FactoryGirl.build(:coupon) }

  describe 'Associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_many(:orders) }
  end

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:code) }
  end

  it 'should create code on create' do
    coupon.save
    expect(coupon.code).to be_present
  end

  describe 'Validity' do
    context 'should give not valid coupon' do
      it 'with expire date' do
        coupon.expiration = Date.today - 1.day
        coupon.save
        expect(coupon.is_valid?).to be_falsy
      end

      it 'with out of quantity' do
        coupon.quantity = 1
        coupon.save
        FactoryGirl.create(:order, coupon: coupon)
        expect(coupon.is_valid?).to be_falsy
      end

      it 'with active - false' do
        coupon.active = false
        coupon.save
        expect(coupon.is_valid?).to be_falsy
      end
    end

    context 'should give valid coupon' do
      it 'with valid attributes' do
        coupon.save
        expect(coupon.is_valid?).to be_truthy
      end
    end
  end
end
