class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.string :start_time
      t.string :take_status
      t.integer :prow_id

      t.timestamps null: false
    end
  end
end
