class BallFlight < ActiveRecord::Base
  has_many :ball_flight_items
  attr_accessible :first_measurement_time, :last_measurement_time, :positions
end
