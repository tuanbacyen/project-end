class CreateConfirmedDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :confirmed_descriptions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :school, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false

      t.timestamps
    end
  end
end
