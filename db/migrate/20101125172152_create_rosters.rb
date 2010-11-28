class CreateRosters < ActiveRecord::Migration
  def self.up
    create_table :rosters do |t|
      t.integer :teamstat_id
      t.integer :player_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rosters
  end
end
