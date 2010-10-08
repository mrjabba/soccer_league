class AddModelRelationalIndices < ActiveRecord::Migration
  def self.up
    add_index :teamstats, :league_id
    add_index :teamstats, :team_id
  end

  def self.down
    remove_index :teamstats, :league_id
    remove_index :teamstats, :team_id
  end
end
