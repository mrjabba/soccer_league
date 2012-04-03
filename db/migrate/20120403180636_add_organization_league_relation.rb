class AddOrganizationLeagueRelation < ActiveRecord::Migration
  def self.up
    add_column :leagues, :organization_id, :integer
    add_index :leagues, :organization_id
  end

  def self.down
    remove_index :leagues, :organization_id
    remove_column :leagues, :organization_id
  end
end
