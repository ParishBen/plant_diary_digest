class AddIdColumnToPlants < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :owner_id, :integer
  end
end
