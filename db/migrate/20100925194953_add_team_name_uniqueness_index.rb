class AddTeamNameUniquenessIndex < ActiveRecord::Migration
  def self.up
   add_index :teams, :name, :unique => true
  end

  def self.down
    remove_index :teams, :name
  end
end
