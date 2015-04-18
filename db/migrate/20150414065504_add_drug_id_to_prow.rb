class AddDrugIdToProw < ActiveRecord::Migration
  def change
    add_column :prows, :drug_id, :intrger
    remove_column :drugs, :prow_id
  end
end
