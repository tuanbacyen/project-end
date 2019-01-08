class RemoveSemesterFromClassSubjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :class_subjects, :semester, foreign_key: true
  end
end
