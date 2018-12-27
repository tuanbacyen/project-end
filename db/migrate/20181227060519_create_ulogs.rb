class CreateUlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :ulogs do |t|
      t.integer :form_user,  null: false
      t.integer :action,     null: false
      t.string :content,     null: false
      t.string :new
      t.string :old

      t.timestamps
    end
  end
end
