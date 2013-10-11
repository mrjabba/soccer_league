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

ActiveRecord::Schema.define(:version => 20131011172549) do

  create_table "games", :force => true do |t|
    t.boolean  "completed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "league_id"
    t.integer  "teamstat1_id"
    t.integer  "teamstat2_id"
  end

  add_index "games", ["created_by_id"], :name => "index_games_on_created_by_id"
  add_index "games", ["updated_by_id"], :name => "index_games_on_updated_by_id"

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "organization_id"
    t.boolean  "supports_games",  :default => true
    t.boolean  "calc_points",     :default => true
    t.string   "coordinate_lat"
    t.string   "coordinate_long"
    t.integer  "zoom_level",      :default => 5
    t.boolean  "show_map",        :default => false
    t.integer  "from_year"
    t.integer  "to_year"
  end

  add_index "leagues", ["created_by_id"], :name => "index_leagues_on_created_by_id"
  add_index "leagues", ["organization_id"], :name => "index_leagues_on_organization_id"
  add_index "leagues", ["updated_by_id"], :name => "index_leagues_on_updated_by_id"

  create_table "leaguezones", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "league_id"
    t.integer  "start_rank"
    t.integer  "end_rank"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "style"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "founded"
    t.string   "website"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birth_date"
    t.string   "nationality"
    t.string   "birth_city"
    t.string   "birth_nation"
    t.decimal  "height",              :precision => 4, :scale => 2
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "people", ["created_by_id"], :name => "index_players_on_created_by_id"
  add_index "people", ["updated_by_id"], :name => "index_players_on_updated_by_id"

  create_table "playerstats", :force => true do |t|
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "shots"
    t.integer  "fouls"
    t.integer  "yellow_cards"
    t.integer  "red_cards"
    t.integer  "minutes"
    t.integer  "saves"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jersey_number"
    t.integer  "game_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "teamstat_id"
  end

  add_index "playerstats", ["created_by_id"], :name => "index_playerstats_on_created_by_id"
  add_index "playerstats", ["person_id"], :name => "index_playerstats_on_player_id"
  add_index "playerstats", ["updated_by_id"], :name => "index_playerstats_on_updated_by_id"

  create_table "playinglocations", :force => true do |t|
    t.integer  "teamstat_id"
    t.integer  "venue_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rosters", :force => true do |t|
    t.integer  "teamstat_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "jersey_number"
    t.string   "position"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "shots"
    t.integer  "fouls"
    t.integer  "yellow_cards"
    t.integer  "red_cards"
    t.integer  "minutes"
    t.integer  "saves"
  end

  add_index "rosters", ["created_by_id"], :name => "index_rosters_on_created_by_id"
  add_index "rosters", ["updated_by_id"], :name => "index_rosters_on_updated_by_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.string   "country"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "teams", ["created_by_id"], :name => "index_teams_on_created_by_id"
  add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true
  add_index "teams", ["updated_by_id"], :name => "index_teams_on_updated_by_id"

  create_table "teamstats", :force => true do |t|
    t.integer  "points"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "games_played"
    t.integer  "team_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  add_index "teamstats", ["created_by_id"], :name => "index_teamstats_on_created_by_id"
  add_index "teamstats", ["league_id"], :name => "index_teamstats_on_league_id"
  add_index "teamstats", ["team_id"], :name => "index_teamstats_on_team_id"
  add_index "teamstats", ["updated_by_id"], :name => "index_teamstats_on_updated_by_id"

  create_table "technicalstaffs", :force => true do |t|
    t.integer  "teamstat_id"
    t.integer  "person_id"
    t.string   "role"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "roles_mask"
    t.boolean  "metric",                              :default => true
    t.integer  "updated_by_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["updated_by_id"], :name => "index_users_on_updated_by_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "surface"
    t.integer  "built"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coordinate_lat"
    t.string   "coordinate_long"
    t.string   "description"
    t.string   "directions"
    t.string   "address"
  end

end
