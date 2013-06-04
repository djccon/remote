class RemoveValidFromBallLanding < ActiveRecord::Migration
  def up
    remove_column :ball_landings, :valid
  end

  def down
    add_column :ball_landings, :valid, :boolean
  end
end
