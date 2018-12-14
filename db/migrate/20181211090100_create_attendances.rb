class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :day_check,        null: false
      t.string :reason,         null: true, default: ""
      t.boolean :confirmed,     null: true, default: false

      t.references :unit, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
