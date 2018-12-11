class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.integer :period,           null: false
      t.date :start_date,          null: false, default: DateTime.now.strftime("%Y-%d-%m")
      t.date :end_date,            null: false, default: DateTime.now.strftime("%Y-%d-%m")
      t.string :school_year,       null: false

      t.timestamps
    end
  end
end
