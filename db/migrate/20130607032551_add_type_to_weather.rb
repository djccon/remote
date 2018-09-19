class AddTypeToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :type, :string
  end
end
