class ClubPath < ActiveRecord::Base
  has_many :club_path_items
  attr_accessible :first_measurement_time, :last_measurement_time, :positions
end
