class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.integer :founded
      t.string :website
      t.integer :updated_by_id
      t.integer :created_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
