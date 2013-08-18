class AddMapOptionsToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :coordinate_lat, :string
    add_column :leagues, :coordinate_long, :string
    add_column :leagues, :zoom_level, :integer, :default => 5
    add_column :leagues, :show_map, :boolean, :default => false
  end
end
