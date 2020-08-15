class DeleteIdFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :owner_id, :integer
  end
end
