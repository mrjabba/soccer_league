class VenueSplitLatLong < ActiveRecord::Migration
  def self.up
    add_column :venues, :coordinate_lat, :string
    add_column :venues, :coordinate_long, :string
    remove_column :venues, :coordinates
  end

  def self.down
    add_column :venues, :coordinates, :string
  end
end
