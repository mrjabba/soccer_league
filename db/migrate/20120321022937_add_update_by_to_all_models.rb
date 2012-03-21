class AddUpdateByToAllModels < ActiveRecord::Migration
  def self.up
    add_column :leagues, :updated_by_id, :integer
    add_column :games, :updated_by_id, :integer
    add_column :players, :updated_by_id, :integer
    add_column :playerstats, :updated_by_id, :integer
    add_column :rosters, :updated_by_id, :integer
    add_column :teams, :updated_by_id, :integer
    add_column :teamstats, :updated_by_id, :integer
    add_column :users, :updated_by_id, :integer

    add_index :leagues, :updated_by_id
    add_index :games, :updated_by_id
    add_index :players, :updated_by_id
    add_index :playerstats, :updated_by_id
    add_index :rosters, :updated_by_id
    add_index :teams, :updated_by_id
    add_index :teamstats, :updated_by_id
    add_index :users, :updated_by_id
  end

  def self.down
    remove_column :leagues, :updated_by_id
    remove_column :games, :updated_by_id
    remove_column :players, :updated_by_id
    remove_column :playerstats, :updated_by_id
    remove_column :rosters, :updated_by_id
    remove_column :teams, :updated_by_id
    remove_column :teamstats, :updated_by_id
    remove_column :users, :updated_by_id
  end
end
