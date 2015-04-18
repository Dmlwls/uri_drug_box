class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.integer :user_id
      t.string :doctor_name 

      t.timestamps null: false
    end
  end
end
