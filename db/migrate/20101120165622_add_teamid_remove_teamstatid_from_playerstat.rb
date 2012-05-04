class AddTeamidRemoveTeamstatidFromPlayerstat < ActiveRecord::Migration

  def self.up
    add_column :playerstats, :team_id, :integer
    add_index :playerstats, :team_id

    remove_column :playerstats, :teamstat_id
    # remove_index :playerstats, :teamstat_id
  end

  def self.down
    remove_column :playerstats, :team_id
    remove_index :playerstats, :team_id

    add_column :playerstats, :teamstat_id, :integer
    add_index :playerstats, :teamstat_id

  end
end
