class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.float :wind_speed
      t.float :wind_direction

      t.timestamps
    end
  end
end
