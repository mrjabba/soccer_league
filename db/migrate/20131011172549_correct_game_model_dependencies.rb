#NOTE this migration is destructive! 
# I'm not bothering migrating existing games here
# This change will fix an oversight with the game and playerstat model.
# For game, 
#   by depending on teamstats instead of teams directly, the game will properly
#   reference a team's place in a league, season or cup. Otherwise you can't track games 
#   across seasons as easily
# For playerstat,
#  they belong to a game and a team. But it, needs to be a teamstat so we can track 
#  the specific league, season or cup for that stat.
class CorrectGameModelDependencies < ActiveRecord::Migration
  def up
    #BE WARNED. Games and playerstats being removed here!
    Playerstat.delete_all
    Game.delete_all
    remove_column :games, :team1_id
    remove_column :games, :team2_id
    add_column :games, :teamstat1_id, :integer
    add_column :games, :teamstat2_id, :integer

    remove_column :playerstats, :team_id
    add_column :playerstats, :teamstat_id, :integer
  end

  def down
    add_column :games, :team1_id, :integer
    add_column :games, :team2_id, :integer
    remove_column :games, :teamstat1_id
    remove_column :games, :teamstat2_id

    add_column :playerstats, :team_id, :integer
    remove_column :playerstats, :teamstat_id
  end
end
