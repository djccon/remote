class ResultItem < ActiveRecord::Base
	belongs_to :users
	attr_accessible :distance_from_hole, :shot_id, :user_id
end
