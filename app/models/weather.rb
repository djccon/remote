class Weather < ActiveRecord::Base
  has_many :weather_items
  attr_accessible :wind_direction, :wind_speed
end
