class AddMetricPreference < ActiveRecord::Migration
  def self.up
    add_column :users, :metric, :boolean, :default => true
  end

  def self.down
    remove_column :users, :metric
  end
end
