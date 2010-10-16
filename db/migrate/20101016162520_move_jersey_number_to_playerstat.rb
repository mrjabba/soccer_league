class MoveJerseyNumberToPlayerstat < ActiveRecord::Migration
  def self.up
    add_column :playerstats, :jersey_number, :integer
    remove_column :players, :jersey_number
  end

  def self.down
    remove_column :playerstats, :jersey_number
    add_column :players, :jersey_number, :integer
  end
end
