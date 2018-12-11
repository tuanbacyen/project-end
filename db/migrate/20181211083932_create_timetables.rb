class CreateTimetables < ActiveRecord::Migration[5.2]
  def change
    create_table :timetables do |t|
      t.string :name,     null: false
      t.integer :day,     null: false

      t.references :class_subject, foreign_key: true, null: false
      t.references :unit, foreign_key: true, null: false

      t.timestamps
    end
  end
end
