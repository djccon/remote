class CreateLaunches < ActiveRecord::Migration
  def change
    create_table :launches do |t|
      t.float :club_speed
      t.float :ball_speed
      t.float :smash_factor
      t.float :ball_horizontal_angle
      t.float :ball_vertical_angle
      t.float :dynamic_loft
      t.float :face_angle
      t.float :spin_rate
      t.float :spin_axis_horizontal
      t.float :spin_axis_vertical
      t.float :club_path
      t.float :attack_angle
      t.float :swing_plane_horizontal
      t.float :swing_plane_vertical

      t.timestamps
    end
  end
end
