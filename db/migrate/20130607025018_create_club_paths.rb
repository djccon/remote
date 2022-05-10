class CreateClubPaths < ActiveRecord::Migration
  def change
    create_table :club_paths do |t|
      t.float :first_measurement_time
      t.float :last_measurement_time
      t.text :positions

      t.timestamps
    end
  end
end
