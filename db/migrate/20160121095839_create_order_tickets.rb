class CreateOrderTickets < ActiveRecord::Migration
  def change
    create_table :order_tickets do |t|
      t.integer :ticket_id
      t.integer :order_id
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
