class NewPlayerFields < ActiveRecord::Migration
  def self.up
    add_column :players, :jersey_number, :integer
    add_column :players, :birth_date, :date
    add_column :players, :nationality, :string
    add_column :players, :previous_club, :string
  end

  def self.down
    remove_column :players, :jersey_number
    remove_column :players, :birth_date
    remove_column :players, :nationality
    remove_column :players, :previous_club
  end
end
