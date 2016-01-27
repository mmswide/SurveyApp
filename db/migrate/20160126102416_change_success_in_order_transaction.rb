class ChangeSuccessInOrderTransaction < ActiveRecord::Migration
  def change
    change_column :order_transactions, :success, :boolean
  end
end
