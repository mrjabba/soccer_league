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

ActiveRecord::Schema.define(:version => 20110102183040) do

  create_table "games", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "league_id"
    t.boolean  "completed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birth_date"
    t.string   "nationality"
    t.string   "birth_city"
    t.string   "birth_nation"
    t.integer  "height"
  end

  create_table "playerstats", :force => true do |t|
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "shots"
    t.integer  "fouls"
    t.integer  "yellow_cards"
    t.integer  "red_cards"
    t.integer  "minutes"
    t.integer  "saves"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jersey_number"
    t.integer  "game_id"
    t.integer  "team_id"
  end

  add_index "playerstats", ["player_id"], :name => "index_playerstats_on_player_id"
  add_index "playerstats", ["team_id"], :name => "index_playerstats_on_team_id"

  create_table "rosters", :force => true do |t|
    t.integer  "teamstat_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true

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
  end

  add_index "teamstats", ["league_id"], :name => "index_teamstats_on_league_id"
  add_index "teamstats", ["team_id"], :name => "index_teamstats_on_team_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
