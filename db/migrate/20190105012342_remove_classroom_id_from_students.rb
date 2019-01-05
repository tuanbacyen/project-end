class RemoveClassroomIdFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_reference :students, :classroom, foreign_key: true
  end
end
