class AddCreatedByToAllTables < ActiveRecord::Migration
  def self.up
    add_column :leagues, :created_by_id, :integer
    add_column :games, :created_by_id, :integer
    add_column :players, :created_by_id, :integer
    add_column :playerstats, :created_by_id, :integer
    add_column :rosters, :created_by_id, :integer
    add_column :teams, :created_by_id, :integer
    add_column :teamstats, :created_by_id, :integer

    add_index :leagues, :created_by_id
    add_index :games, :created_by_id
    add_index :players, :created_by_id
    add_index :playerstats, :created_by_id
    add_index :rosters, :created_by_id
    add_index :teams, :created_by_id
    add_index :teamstats, :created_by_id
  end

  def self.down
    remove_column :leagues, :created_by_id
    remove_column :games, :created_by_id
    remove_column :players, :created_by_id
    remove_column :playerstats, :created_by_id
    remove_column :rosters, :created_by_id
    remove_column :teams, :created_by_id
    remove_column :teamstats, :created_by_id
  end
end
