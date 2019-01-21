class AddInforStudentToConfirmedDescription < ActiveRecord::Migration[5.2]
  def change
    add_column :confirmed_descriptions, :infor_student, :string
  end
end
