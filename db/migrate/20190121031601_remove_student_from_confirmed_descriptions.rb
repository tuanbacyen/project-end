class RemoveStudentFromConfirmedDescriptions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :confirmed_descriptions, :student, foreign_key: true
  end
end
