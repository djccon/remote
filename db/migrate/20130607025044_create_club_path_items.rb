class CreateClubPathItems < ActiveRecord::Migration
  def change
    create_table :club_path_items do |t|
      t.integer :shot_id
      t.integer :club_path_id

      t.timestamps
    end
  end
end
