class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name,       null: false
      t.string :adress,     null: false
      t.string :phone,      null: false

      t.timestamps
    end
  end
end
