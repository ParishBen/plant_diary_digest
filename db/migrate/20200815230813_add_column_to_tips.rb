class AddColumnToTips < ActiveRecord::Migration[5.2]
  def change
    add_column :tips, :owner_id, :integer
  end
end
