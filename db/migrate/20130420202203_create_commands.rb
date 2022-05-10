class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :cmd
      t.timestamps
    end
  end
end
