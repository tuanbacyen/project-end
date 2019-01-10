class RemoveUserFromClassSubjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :class_subjects, :user, foreign_key: true
  end
end
