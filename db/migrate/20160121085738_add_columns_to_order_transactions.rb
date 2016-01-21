class AddColumnsToOrderTransactions < ActiveRecord::Migration
  def change
    add_column :order_transactions, :success, :string
    add_column :order_transactions, :authorization, :string
    add_column :order_transactions, :message, :string
    add_column :order_transactions, :params, :string
  end
end
