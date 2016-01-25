class CreateOrderTransactions < ActiveRecord::Migration
  def change
    create_table :order_transactions do |t|

      t.timestamps null: false
    end
  end
end
