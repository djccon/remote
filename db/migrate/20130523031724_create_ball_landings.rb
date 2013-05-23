class CreateBallLandings < ActiveRecord::Migration
  def change
    create_table :ball_landings do |t|
      t.boolean :valid
      t.float :time
      t.float :x
      t.float :y
      t.float :z
      t.float :carry
      t.float :side
      t.float :vertical_angle
      t.float :horizontal_angle
      t.float :speed

      t.timestamps
    end
  end
end
