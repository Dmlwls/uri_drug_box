class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.string :email :null => false
      t.string :phone_number 
      t.integer :user_id
      t.string :name
      
      t.timestamps null: false
    end
  end
end
