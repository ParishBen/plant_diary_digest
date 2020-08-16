class RemoveOwnerFromPlantsAddUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :owner_id, :integer
    add_column :plants, :user_id, :integer
  end
end
