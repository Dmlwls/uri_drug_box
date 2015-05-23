class AddUserIdToBoxPart < ActiveRecord::Migration
  def change
    add_column :box_parts, :user_id, :integer
  end
end
