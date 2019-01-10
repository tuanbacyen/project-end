class RemoveSubjectFromClassSubject < ActiveRecord::Migration[5.2]
  def change
    remove_reference :class_subjects, :subject, foreign_key: true
  end
end
