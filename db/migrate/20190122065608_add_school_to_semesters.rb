class AddSchoolToSemesters < ActiveRecord::Migration[5.2]
  def change
    add_reference :semesters, :school, foreign_key: true
  end
end
