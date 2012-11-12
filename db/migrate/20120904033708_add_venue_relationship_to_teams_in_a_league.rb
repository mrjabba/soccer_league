class AddVenueRelationshipToTeamsInALeague < ActiveRecord::Migration
  def self.up
    create_table :playinglocations do |t|
      t.integer :teamstat_id
      t.integer :venue_id
      t.integer :updated_by_id
      t.integer :created_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :playinglocations
  end
end
