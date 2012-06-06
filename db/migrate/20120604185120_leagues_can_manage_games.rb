class LeaguesCanManageGames < ActiveRecord::Migration
  def self.up
    add_column :leagues, :supports_games, :boolean, :default => true
    League.update_all ["supports_games = ?", true]
  end

  def self.down
    remove_column :leagues, :supports_games
  end
end
