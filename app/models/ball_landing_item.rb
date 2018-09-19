class BallLandingItem < ActiveRecord::Base
  belongs_to :ball_landing
  belongs_to :shot
  attr_accessible :ball_landing_id, :shot_id
end
