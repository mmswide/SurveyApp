class AddMoreUserFeilds < ActiveRecord::Migration
  def change
  	add_column :users, :contact_number, :string
    add_column :users, :country_of_origin, :string
    add_column :users, :current_location, :string
    add_column :users, :facebook, :string
    add_column :users, :instagram, :string
    add_column :users, :youtube, :string
  end
end
