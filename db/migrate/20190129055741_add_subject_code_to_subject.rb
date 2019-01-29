class AddSubjectCodeToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :subject_code, :string, null: false
  end
end
