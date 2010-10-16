class AddRelationalIndexPlayerstatsTeamstats < ActiveRecord::Migration
  def self.up
    add_column :playerstats, :teamstat_id, :integer
    add_index :playerstats, :teamstat_id
  end

  def self.down
    remove_column :playerstats, :teamstat_id
    remove_index :playerstats, :teamstat_id
  end
end
