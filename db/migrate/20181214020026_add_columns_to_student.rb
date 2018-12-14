class AddColumnsToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :avatar, :string
    add_column :students, :studying, :boolean
  end
end
