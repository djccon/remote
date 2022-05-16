class AddWeatherTypeToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :weather_type, :string
  end
end
