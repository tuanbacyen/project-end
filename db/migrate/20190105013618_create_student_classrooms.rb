class CreateStudentClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :student_classrooms do |t|
      t.references :student, foreign_key: true, null: false
      t.references :classroom, foreign_key: true, null: false

      t.timestamps
    end
  end
end
