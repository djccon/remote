class CreateLiveXyzs < ActiveRecord::Migration
  def change
    create_table :live_xyzs do |t|
      t.float :x
      t.float :y
      t.float :z
      t.float :time

      t.timestamps
    end
  end
end
