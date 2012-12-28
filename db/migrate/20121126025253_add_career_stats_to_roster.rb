class AddCareerStatsToRoster < ActiveRecord::Migration
  def up
    add_column :rosters, :goals, :integer
    add_column :rosters, :assists, :integer
    add_column :rosters, :shots, :integer
    add_column :rosters, :fouls, :integer
    add_column :rosters, :yellow_cards, :integer
    add_column :rosters, :red_cards, :integer
    add_column :rosters, :minutes, :integer
    add_column :rosters, :saves, :integer
  end

  def down
    remove_column :rosters, :goals
    remove_column :rosters, :assists
    remove_column :rosters, :shots
    remove_column :rosters, :fouls
    remove_column :rosters, :yellow_cards
    remove_column :rosters, :red_cards
    remove_column :rosters, :minutes
    remove_column :rosters, :saves
  end
end
