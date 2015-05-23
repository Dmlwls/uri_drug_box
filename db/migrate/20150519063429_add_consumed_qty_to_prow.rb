class AddConsumedQtyToProw < ActiveRecord::Migration
  def change
    add_column :prows, :consumed_qty, :integer
  end
end
