class CreateTickets < ActiveRecord::Migration
  def up
    create_table :tickets do |t|
      t.integer 'event_id' 
      t.string 	'ticket_name'
      t.text 	'ticket_decription'
      t.decimal 'ticket_price'
      t.integer 'quantity'

      t.timestamps null: false
    end
  end

  def down
  	drop_table :tickets
  end
end
