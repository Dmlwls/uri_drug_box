class AddQtyToProw < ActiveRecord::Migration
  def change
    add_column :prows, :qty, :integer 
  end
end
