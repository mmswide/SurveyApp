class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ticket_amount, :integer
    add_column :orders, :fee, :integer
    add_column :orders, :buyer_first_name, :string
    add_column :orders, :buyer_last_name, :string
    add_column :orders, :card_expires_year, :integer
    add_column :orders, :card_expires_month, :integer
    add_column :orders, :card_type, :string
    add_column :orders, :address1, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :integer
  end
end
