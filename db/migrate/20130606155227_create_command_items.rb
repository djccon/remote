class CreateCommandItems < ActiveRecord::Migration
  def change
    create_table :command_items do |t|
      t.integer :shot_id
      t.integer :command_id

      t.timestamps
    end
  end
end
