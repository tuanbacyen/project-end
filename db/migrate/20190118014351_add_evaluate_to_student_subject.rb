class AddEvaluateToStudentSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :student_subjects, :evaluate, :string
  end
end
