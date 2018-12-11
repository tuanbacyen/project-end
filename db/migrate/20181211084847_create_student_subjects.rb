class CreateStudentSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :student_subjects do |t|
      t.float :average,           null: true, default: 0.0
      t.float :average_total,     null: true, default: 0.0
      t.string :classification,   null: true, default: "F"


      t.references :student, foreign_key: true, null: false
      t.references :class_subject, foreign_key: true, null: false

      t.timestamps
    end
  end
end
