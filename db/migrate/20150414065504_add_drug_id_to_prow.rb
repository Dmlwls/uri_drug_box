class AddDrugIdToProw < ActiveRecord::Migration
  def change
    add_column :prows, :drug_id, :integer
    remove_column :drugs, :prow_id
  end
end
