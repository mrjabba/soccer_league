class AddGoalsToGames < ActiveRecord::Migration
  def change
    add_column :games, :goals1_id, :integer, :default => 0
    add_column :games, :goals2_id, :integer, :default => 0
  end
end
