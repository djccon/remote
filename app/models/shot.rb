class Shot < ActiveRecord::Base
	has_many :launch_items, dependent: :destroy
end
