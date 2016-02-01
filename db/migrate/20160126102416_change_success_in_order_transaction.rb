class ChangeSuccessInOrderTransaction < ActiveRecord::Migration
  def self.up
<<<<<<< HEAD
    change_column :order_transactions, :success, :boolean
=======
    change_column :order_transactions, :success, 'boolean USING CAST("success" AS boolean)'
  end

  def self.down
    change_column :order_transactions, :success, :string
>>>>>>> UpdateHomeUi
  end

  def self.down
    change_column :order_transactions, :success, :string
  end
end

