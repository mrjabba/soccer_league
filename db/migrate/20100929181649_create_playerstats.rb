class CreatePlayerstats < ActiveRecord::Migration
  def self.up
    create_table :playerstats do |t|
      t.integer :goals
      t.integer :assists
      t.integer :shots
      t.integer :fouls
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :minutes
      t.integer :saves
      t.integer :player_id

      t.timestamps
    end
    add_index :playerstats, :player_id
  end

  def self.down
    drop_table :playerstats
  end
end
