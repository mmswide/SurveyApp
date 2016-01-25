class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :raw_price, :integer
    add_column :orders, :total_price, :integer
  end
end
