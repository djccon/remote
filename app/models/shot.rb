class Shot < ActiveRecord::Base
	has_many :launch_items, dependent: :destroy
	has_many :ball_landing_items, dependent: :destroy
	has_many :command_items, dependent: :destroy
end
