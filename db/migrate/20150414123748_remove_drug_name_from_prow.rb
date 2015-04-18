class RemoveDrugNameFromProw < ActiveRecord::Migration
  def change
  	remove_column :prows, :drug_name
  end
end
