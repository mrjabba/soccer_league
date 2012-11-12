class AddVenue < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :coordinates
      t.string :surface
      t.integer :built
      t.integer :updated_by_id
      t.integer :created_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
