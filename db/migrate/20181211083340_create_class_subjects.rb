class CreateClassSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :class_subjects do |t|
      t.references :classroom, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.references :semester, foreign_key: true, null: false

      t.timestamps
    end
  end
end
