class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :student_code,     null: false
      t.date :birth,              null: false
      t.string :address,          null: false
      t.string :favorite,         null: true, default: ""
      t.string :phone,            null: true, default: ""
      t.string :father_name,      null: true, default: ""
      t.string :father_phone,     null: true, default: ""
      t.string :mother_name,      null: true, default: ""
      t.string :mother_phone,     null: true, default: ""

      t.references :user, foreign_key: true, null: false
      t.references :classroom, foreign_key: true, null: false

      t.timestamps
    end
  end
end
