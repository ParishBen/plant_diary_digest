class CreatePlantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :common_name
      t.string :nickname
      t.string :plant_type
      t.string :last_watering_date
    end
  end
end
