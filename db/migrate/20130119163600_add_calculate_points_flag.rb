class AddCalculatePointsFlag < ActiveRecord::Migration
  def up
    add_column :leagues, :calc_points, :boolean, :default => true
    League.update_all ["calc_points = ?", true]
  end

  def down
    remove_column :leagues, :calc_points
  end
end
