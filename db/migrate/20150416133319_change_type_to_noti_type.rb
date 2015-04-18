class ChangeTypeToNotiType < ActiveRecord::Migration
  def change
  		remove_column :notifications, :type
  	  	add_column :notifications, :noti_type , :boolean
  end
end
