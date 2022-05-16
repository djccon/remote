class CreateBallFlights < ActiveRecord::Migration
  def change
    create_table :ball_flights do |t|
      t.float :first_measurement_time
      t.float :last_measurement_time
      t.text :positions

      t.timestamps
    end
  end
end
