class UpdateUserModel < ActiveRecord::Migration
  def up
  	add_column :users, :contact_number, :string
  	add_column :users, :country_of_origin, :string
  	add_column :users, :current_location, :string
  	add_column :users, :facebook_link, :string
  	add_column :users, :instagram_link, :string
  	add_column :users, :twitter_link, :string
  	add_column :users, :youtube_link, :string
  	add_column :users, :is_promoter, :boolean, default: false
  	add_column :users, :is_dancer, :boolean, default: false
  	add_column :users, :is_performer, :boolean, default: false
  	add_column :users, :is_dj, :boolean, default: false
  	add_column :users, :is_instructor, :boolean, default: false
  	add_column :users, :is_team_manager, :boolean, default: false
  	add_column :users, :is_vendor, :boolean, default: false
  end

  def down
  	remove_column :users, :contact_number
  	remove_column :users, :country_of_origin
  	remove_column :users, :current_location
  	remove_column :users, :facebook_link
  	remove_column :users, :instagram_link
  	remove_column :users, :twitter_link
  	remove_column :users, :youtube_link
  	remove_column :users, :is_promoter
  	remove_column :users, :is_dancer
  	remove_column :users, :is_performer
  	remove_column :users, :is_dj
  	remove_column :users, :is_instructor
  	remove_column :users, :is_team_manager
  	remove_column :users, :is_vendor
  end
end
