class RemovingUserDataFromEventModel < ActiveRecord::Migration
  def change
  	remove_column :events, :contact_name, :string
    remove_column :events, :contact_phone, :text
    remove_column :events, :contact_email, :string
    rename_column :users, :name, :first_name
    rename_column :tickets, :ticket_decription, :ticket_description
    add_column    :users, :last_name, :string
    add_column    :users, :alias, :string
    add_column    :users, :event_contact_phone, :string
    add_column 	  :users, :event_contact_email, :string
  end
end
