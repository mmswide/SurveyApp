class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.integer :day_id
      t.datetime :hour
      t.string :description

      t.timestamps null: false
    end
  end
end
