class CreateUserSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subjects do |t|
      t.references :user, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false

      t.timestamps
    end
  end
end
