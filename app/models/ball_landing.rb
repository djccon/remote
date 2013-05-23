class BallLanding < ActiveRecord::Base
  attr_accessible :carry, :horizontal_angle, :side, :speed, :time, :valid, :vertical_angle, :x, :y, :z
end
