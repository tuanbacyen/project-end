class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.float :point,       null: true, default: 0.0

      t.references :point_type, foreign_key: true, null: false
      t.references :student_subject, foreign_key: true, null: false

      t.timestamps
    end
  end
end
