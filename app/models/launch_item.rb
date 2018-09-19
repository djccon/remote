class LaunchItem < ActiveRecord::Base
  belongs_to :launch
  belongs_to :shot
  attr_accessible :launch_id, :shot_id
end
