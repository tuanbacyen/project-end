class AddSchoolToUnits < ActiveRecord::Migration[5.2]
  def change
    add_reference :units, :school, foreign_key: true
  end
end
