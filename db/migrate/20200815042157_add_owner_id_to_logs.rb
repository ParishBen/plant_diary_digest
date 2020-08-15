class AddOwnerIdToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :owner_id, :integer
  end
end
