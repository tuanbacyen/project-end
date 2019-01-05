class RemoveStudentFromStudentSubjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :student_subjects, :student, foreign_key: true
  end
end
