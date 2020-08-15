class CreateLogsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.text :content
      t.integer :plant_id
      t.string :condition_update
      t.string :watered_date
    end
  end
end
