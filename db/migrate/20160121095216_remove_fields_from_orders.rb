class RemoveFieldsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :transaction_id, :integer
    remove_column :orders, :ticket_id, :integer
  end
end
