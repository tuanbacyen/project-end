class CreateSchoolUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :school_users do |t|
      t.references :user, foreign_key: true, null: false
      t.references :school, foreign_key: true, null: false

      t.timestamps
    end
  end
end
