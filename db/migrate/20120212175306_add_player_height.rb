class AddPlayerHeight < ActiveRecord::Migration
  def self.up
    change_column :players, :height, :decimal, :precision => 4, :scale => 2
  end

  def self.down
    remove_column :players, :height
  end
end
