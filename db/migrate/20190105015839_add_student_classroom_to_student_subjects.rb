class AddStudentClassroomToStudentSubjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_subjects, :student_classroom, foreign_key: true
  end
end
