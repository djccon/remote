class CreateDebugOutputs < ActiveRecord::Migration
  def change
    create_table :debug_outputs do |t|
      t.string :title
      t.text :detail

      t.timestamps
    end
  end
end
