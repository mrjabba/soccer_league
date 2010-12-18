class TeamAddCountryColumn < ActiveRecord::Migration
  def self.up
    add_column :teams, :country, :string
  end

  def self.down
    remove_column :teams, :country
  end
end
