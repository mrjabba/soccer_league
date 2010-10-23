class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :league_id

      t.timestamps
    end
    
    add_column :playerstats, :match_id, :integer
    
  end

  def self.down
    drop_table :matches
    remove_column :playerstats, :match_id
  end
end
