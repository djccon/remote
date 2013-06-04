class CreateBallLandingItems < ActiveRecord::Migration
  def change
    create_table :ball_landing_items do |t|
      t.integer :shot_id
      t.integer :ball_landing_id

      t.timestamps
    end
  end
end
