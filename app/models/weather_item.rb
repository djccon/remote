class WeatherItem < ActiveRecord::Base
  belongs_to :weather
  belongs_to :shot
  attr_accessible :shot_id, :weather_id
end
