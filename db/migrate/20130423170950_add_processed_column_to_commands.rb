class AddProcessedColumnToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :processed, :boolean
  end
end
