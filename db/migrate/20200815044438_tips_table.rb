class TipsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.text :content
      t.string :plant_type
      t.string :care_category
    end
  end
end
