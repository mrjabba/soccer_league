class PlayerDropPreviousClub < ActiveRecord::Migration
  def self.up
    remove_column :players, :previous_club
  end

  def self.down
    add_column :players, :previous_club, :string
   end
end
