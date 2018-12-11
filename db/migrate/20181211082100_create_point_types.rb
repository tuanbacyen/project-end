class CreatePointTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :point_types do |t|
      t.string :name,      null: false
      t.float :value,      null: false

      t.timestamps
    end
  end
end
