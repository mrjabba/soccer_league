class AddPositionAndNumberToRoster < ActiveRecord::Migration
  def self.up
    add_column :rosters, :jersey_number, :integer
    add_column :rosters, :position, :string
  end

  def self.down
    remove_column :rosters, :jersey_number
    remove_column :rosters, :position
  end
end
