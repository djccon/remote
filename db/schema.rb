# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130912135832) do

  create_table "ball_flight_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "ball_flight_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "ball_flights", :force => true do |t|
    t.float    "first_measurement_time"
    t.float    "last_measurement_time"
    t.text     "positions"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "ball_landing_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "ball_landing_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "ball_landings", :force => true do |t|
    t.float    "time"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "carry"
    t.float    "side"
    t.float    "vertical_angle"
    t.float    "horizontal_angle"
    t.float    "speed"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "club_path_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "club_path_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "club_paths", :force => true do |t|
    t.float    "first_measurement_time"
    t.float    "last_measurement_time"
    t.text     "positions"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "command_blocks", :force => true do |t|
    t.string   "commands"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "command_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "command_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "commands", :force => true do |t|
    t.string   "cmd"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "processed"
  end

  create_table "debug_outputs", :force => true do |t|
    t.string   "title"
    t.text     "detail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "launch_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "launch_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "launches", :force => true do |t|
    t.float    "club_speed"
    t.float    "ball_speed"
    t.float    "smash_factor"
    t.float    "ball_horizontal_angle"
    t.float    "ball_vertical_angle"
    t.float    "dynamic_loft"
    t.float    "face_angle"
    t.float    "spin_rate"
    t.float    "spin_axis_horizontal"
    t.float    "spin_axis_vertical"
    t.float    "club_path"
    t.float    "attack_angle"
    t.float    "swing_plane_horizontal"
    t.float    "swing_plane_vertical"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "live_xyzs", :force => true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "command_id"
    t.string   "response"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "result_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "shot_id"
    t.float    "distance_from_hole"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "shots", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weather_items", :force => true do |t|
    t.integer  "shot_id"
    t.integer  "weather_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weathers", :force => true do |t|
    t.float    "wind_speed"
    t.float    "wind_direction"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "weather_type"
  end

end
