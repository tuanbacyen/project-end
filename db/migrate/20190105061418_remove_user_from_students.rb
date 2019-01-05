class RemoveUserFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_reference :students, :user, foreign_key: true
  end
end
