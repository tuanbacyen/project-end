class AddUserToDayOff < ActiveRecord::Migration[5.2]
  def change
    add_reference :day_offs, :user, foreign_key: true
  end
end
