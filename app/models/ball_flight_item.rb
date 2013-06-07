class BallFlightItem < ActiveRecord::Base
  belongs_to :ball_flight
  belongs_to :shot
  attr_accessible :ball_flight_id, :shot_id
end
