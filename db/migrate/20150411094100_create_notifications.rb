class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type 
      t.string :destination 
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
