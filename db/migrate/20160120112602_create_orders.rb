class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.integer :transaction_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
