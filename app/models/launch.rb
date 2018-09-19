class Launch < ActiveRecord::Base
  has_many :launch_items

  before_destroy :ensure_not_referenced_by_any_launch_item

  attr_accessible :attack_angle, :ball_horizontal_angle, :ball_speed, :ball_vertical_angle, :club_path, :club_speed, :dynamic_loft, :face_angle, :smash_factor, :spin_axis_horizontal, :spin_axis_vertical, :spin_rate, :swing_plane_horizontal, :swing_plane_vertical

  def ensure_not_referenced_by_any_launch_item
    if launch_items.empty?
      return true
    else 
      errors.add(:base, "launch items present")
      return false
    end
  end

end
