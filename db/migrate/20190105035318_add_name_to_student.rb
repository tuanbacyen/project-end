class AddNameToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :name, :string, null: false
  end
end
