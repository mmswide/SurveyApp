class RenameOrderTicketsToEntitlements < ActiveRecord::Migration
  def change
    rename_table :order_tickets, :entitlements
  end
end
