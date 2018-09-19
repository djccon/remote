class User < ActiveRecord::Base
	has_many :result_items
	attr_accessible :email, :name
end
