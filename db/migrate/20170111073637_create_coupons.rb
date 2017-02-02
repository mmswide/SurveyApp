class CreateCoupons < ActiveRecord::Migration
  def change
    create_table  :coupons do |t|
      t.references  :event, index: true
      t.integer     :quantity, default: 1
      t.boolean     :active, default: true
      t.string      :code
      t.string      :discount_type, default: 'fixed_amount'
      t.integer     :discount_amount_cents
      t.integer     :discount_percentage
      t.date        :expiration
      t.string      :description

      t.timestamps null: false
    end
  end
end
