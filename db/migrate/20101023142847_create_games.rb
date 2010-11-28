class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :league_id
      t.boolean :completed, :default => false

      t.timestamps
    end
    
    add_column :playerstats, :game_id, :integer
    
  end

  def self.down
    drop_table :games
    remove_column :playerstats, :game_id
  end
end
