class AddUserSubjectToClassSubjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :class_subjects, :user_subject, foreign_key: true
  end
end
