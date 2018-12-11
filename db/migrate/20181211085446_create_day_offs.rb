class CreateDayOffs < ActiveRecord::Migration[5.2]
  def change
    create_table :day_offs do |t|
      t.date :date_off,       null: true, default: DateTime.now.strftime("%Y-%d-%m")
      t.string :reason,       null: false, default: ""
      t.boolean :confirmed,   null: true, default: false

      t.references :student, foreign_key: true, null: false

      t.timestamps
    end
  end
end
