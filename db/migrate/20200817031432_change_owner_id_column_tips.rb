class ChangeOwnerIdColumnTips < ActiveRecord::Migration[5.2]
  def change
    remove_column :tips, :owner_id, :integer
    add_column :tips, :user_id, :integer
  end
end
