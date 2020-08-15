class RemoveWateringDateFromPlants < ActiveRecord::Migration[5.2]
  def change
    remove_column :plants, :last_watering_date, :string
  end
end
