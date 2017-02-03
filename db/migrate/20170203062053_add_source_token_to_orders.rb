class AddSourceTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :source_token, :string
  end
end
