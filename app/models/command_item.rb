class CommandItem < ActiveRecord::Base
  belongs_to :command
  belongs_to :shot
  attr_accessible :command_id, :shot_id
end
