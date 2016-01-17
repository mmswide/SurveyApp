class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer      'user_id'
      t.string       'event_name', :limit => 100
      t.text         'description_short', :limit => 300 
      t.text         'description_long'
      t.string       'event_url'
      t.attachment   'main_image'
      t.attachment   'other_images'
      t.date         'start_date'
      t.date         'end_date'
      t.time         'start_time'
      t.time         'end_time'
      t.string       'contact_name'
      t.text         'contact_phone'
      t.string       'contact_email'
      t.string       'venue_name'
      t.text         'venue_phone'
      t.string       'address_1'
      t.string       'addess_2'
      t.string       'city'
      t.string       'state'
      t.text         'zip_code'
      t.timestamps null: false
    end
  end

  def down
  	drop_table :events
  end
end
