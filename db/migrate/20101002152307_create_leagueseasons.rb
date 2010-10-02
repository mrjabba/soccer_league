class CreateLeagueseasons < ActiveRecord::Migration
  def self.up
    create_table :leagueseasons do |t|
      t.integer :team_id
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leagueseasons
  end
end
