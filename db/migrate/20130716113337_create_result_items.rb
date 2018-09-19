class CreateResultItems < ActiveRecord::Migration
  def change
    create_table :result_items do |t|
      t.integer :user_id
      t.integer :shot_id
      t.float :distance_from_hole

      t.timestamps
    end
  end
end
