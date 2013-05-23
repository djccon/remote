class CreateLaunchItems < ActiveRecord::Migration
  def change
    create_table :launch_items do |t|
      t.integer :shot_id
      t.integer :launch_id

      t.timestamps
    end
  end
end
