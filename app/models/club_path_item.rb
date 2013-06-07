class ClubPathItem < ActiveRecord::Base
  belongs_to :club_path
  belongs_to :shot
  attr_accessible :club_path_id, :shot_id
end
