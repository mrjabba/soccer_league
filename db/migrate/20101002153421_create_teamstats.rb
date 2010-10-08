class CreateTeamstats < ActiveRecord::Migration
  def self.up
    create_table :teamstats do |t|
      t.integer :points
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :goals_for
      t.integer :goals_against
      t.integer :games_played
      t.integer :team_id
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :teamstats
  end
end
