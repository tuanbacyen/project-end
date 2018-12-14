class AddColumnsToClassroom < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :name, :string
    add_column :classrooms, :sizes, :integer
    add_column :classrooms, :number, :integer
  end
end
