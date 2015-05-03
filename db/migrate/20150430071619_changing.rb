class Changing < ActiveRecord::Migration
  def change
  	remove_column :consumptions, :start_time
  	add_column :prows, :start_time, :datetime 
  end
end
