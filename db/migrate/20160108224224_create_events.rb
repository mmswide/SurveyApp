class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer 'user_id'
      t.string  'event_name', :limit => 100
      t.text    'description_short', :limit => 300 
      t.text    'description_long'
      t.string  'profile image_url'
      t.text    'other_images_url'
      t.string  'contact_name'
      t.text    'contact_phone'
      t.string  'contact_email'
      t.string  'venue_name'
      t.text    'venue_phone'
      t.string  'address_1'
      t.string  'addess_2'
      t.string  'city'
      t.string  'state'
      t.text    'zip_code'
      t.timestamps null: false
    end
  end

  def down
  	drop_table :events
  end
end
