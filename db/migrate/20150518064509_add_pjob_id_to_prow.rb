class AddPjobIdToProw < ActiveRecord::Migration
  def change
    add_column :prows, :pjob_id, :integer
  end
end
