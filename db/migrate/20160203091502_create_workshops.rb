class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.datetime :time
      t.string :title
      t.string :instructor
      t.string :level
      t.string :location
      t.string :category
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
