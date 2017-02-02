class Coupon < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :event
  has_many    :orders

  before_validation :set_discount_value, if: :discount

  COUPON_FORMAT = /\A[a-zA-Z\d]*\Z/  # only letters and numbers

  validates :code, uniqueness: true
  validates :quantity, :code, presence: true
  validates :code, format: {  with: COUPON_FORMAT, 
                              message:  'no special characters allowed, 
                                        only letters and numbers' }
  validates :discount_amount_cents, numericality: { greater_than: 0}, 
                                                    allow_blank: true
  validates :discount_percentage,   numericality: { greater_than: 0, 
                                                    less_than_or_equal_to: 100 },
                                                    allow_blank: true
  attr_accessor :discount

  def fixed_amount?
    discount_type == 'fixed_amount'
  end

  def amount
    discount_amount_cents.to_f/100 if discount_amount_cents
  end

  def is_valid?
    active && expiration >= Date.today && used < quantity
  end

  def discount_cents(for_value_cents)
    if fixed_amount?
      discount_amount_cents > for_value_cents ? for_value_cents : discount_amount_cents
    else
      (for_value_cents*discount_percentage/100).to_i
    end
  end

  def used
    orders.count
  end

  private

  def set_discount_value
    if fixed_amount?
      self.discount_amount_cents = discount.to_f * 100
    else
      self.discount_percentage = discount.to_i
    end
  end
end
