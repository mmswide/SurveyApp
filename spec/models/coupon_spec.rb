require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { FactoryGirl.build(:coupon) }

  describe 'Associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_many(:orders) }
  end

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:quantity) }

    context 'should create valid coupon' do
      it 'chars and digits only' do
        coupon.code = '123abc'
        coupon.save
        expect(coupon.valid?).to be_truthy
      end

      it 'chars and digits only' do
        coupon.code = 'abc123'
        coupon.save
        expect(coupon.valid?).to be_truthy
      end

      it 'chars and digits only' do
        coupon.code = '1a2b3c123'
        coupon.save
        expect(coupon.valid?).to be_truthy
      end

      it 'capital chars and digits only' do
        coupon.code = '1A2B3c123'
        coupon.save
        expect(coupon.valid?).to be_truthy
      end
    end

    context 'should NOT create valid coupon' do
      it 'with code includes spec chars' do
        coupon.code = '123&@'
        coupon.save
        expect(coupon.valid?).to be_falsy
      end

      it 'with code includes spaces' do
        coupon.code = '123 aBc'
        coupon.save
        expect(coupon.valid?).to be_falsy
      end

      it 'with code includes more special chars' do
        coupon.code = '123_aBc'
        coupon.save
        expect(coupon.valid?).to be_falsy
      end

      it 'with code includes more special chars' do
        coupon.code = '123a.Bc'
        coupon.save
        expect(coupon.valid?).to be_falsy
      end
    end
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
