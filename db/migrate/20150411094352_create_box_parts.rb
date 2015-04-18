class CreateBoxParts < ActiveRecord::Migration
  def change
    create_table :box_parts do |t|
      t.string :part_num 
      t.integer :prow_id

      t.timestamps null: false
    end
  end
end
