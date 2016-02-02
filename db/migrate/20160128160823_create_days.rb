class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :event_id
      t.string :name
      t.date :date

      t.timestamps null: false
    end
  end
end
