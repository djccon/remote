class CreateBallFlightItems < ActiveRecord::Migration
  def change
    create_table :ball_flight_items do |t|
      t.integer :shot_id
      t.integer :ball_flight_id

      t.timestamps
    end
  end
end
