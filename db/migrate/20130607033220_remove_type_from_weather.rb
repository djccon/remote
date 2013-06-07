class RemoveTypeFromWeather < ActiveRecord::Migration
  def up
    remove_column :weathers, :type
  end

  def down
    add_column :weathers, :type, :string
  end
end
