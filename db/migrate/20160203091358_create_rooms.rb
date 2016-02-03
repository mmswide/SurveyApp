class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :day_id

      t.timestamps null: false
    end
  end
end
