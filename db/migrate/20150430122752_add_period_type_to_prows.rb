class AddPeriodTypeToProws < ActiveRecord::Migration
  def change
    add_column :prows, :period_type, :string
  end
end
