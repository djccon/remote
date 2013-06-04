class BallLanding < ActiveRecord::Base
  has_many :ball_landing_items
  attr_accessible :carry, :horizontal_angle, :side, :speed, :time, :vertical_angle, :x, :y, :z
end
