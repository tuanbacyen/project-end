class CreateSchoolSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :school_subjects do |t|
      t.integer :number,     null: false
      t.references :school, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false

      t.timestamps
    end
  end
end
