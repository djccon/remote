class CreateWeatherItems < ActiveRecord::Migration
  def change
    create_table :weather_items do |t|
      t.integer :shot_id
      t.integer :weather_id

      t.timestamps
    end
  end
end
