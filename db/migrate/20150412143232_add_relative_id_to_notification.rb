class AddRelativeIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :relative_id, :integer
  end
end
