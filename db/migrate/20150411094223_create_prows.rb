class CreateProws < ActiveRecord::Migration
  def change
    create_table :prows do |t|
      t.integer :prescription_id 
      t.string :period 

      t.timestamps null: false
    end
  end
end
