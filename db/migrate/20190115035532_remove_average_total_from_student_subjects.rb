class RemoveAverageTotalFromStudentSubjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_subjects, :average_total, :float
  end
end
