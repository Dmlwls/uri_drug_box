class ChangeStartTimeType < ActiveRecord::Migration
  def change
  	change_column :consumptions, :start_time , :datetime
  end
end
