class CreateCommandBlocks < ActiveRecord::Migration
  def change
    create_table :command_blocks do |t|
      t.string :commands

      t.timestamps
    end
  end
end
