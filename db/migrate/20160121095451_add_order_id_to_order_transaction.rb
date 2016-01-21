class AddOrderIdToOrderTransaction < ActiveRecord::Migration
  def change
    add_column :order_transactions, :order_id, :integer
  end
end
