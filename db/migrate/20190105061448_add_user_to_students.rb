class AddUserToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :user, foreign_key: true, null: true
  end
end
