class RemoveAmountFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :amount, :integer
  end
end
