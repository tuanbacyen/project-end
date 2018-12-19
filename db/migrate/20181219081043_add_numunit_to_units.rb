class AddNumunitToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :numunit, :integer
  end
end
