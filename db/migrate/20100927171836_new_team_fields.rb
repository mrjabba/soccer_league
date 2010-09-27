class NewTeamFields < ActiveRecord::Migration
  def self.up
    add_column :teams, :address2, :string
    add_column :teams, :city, :string
    add_column :teams, :state, :string
    add_column :teams, :zip, :string
    add_column :teams, :phone, :string
    add_column :teams, :website, :string
    add_column :teams, :email, :string
  end

  def self.down
    remove_column :teams, :address2
    remove_column :teams, :city
    remove_column :teams, :state
    remove_column :teams, :zip
    remove_column :teams, :phone
    remove_column :teams, :website
    remove_column :teams, :email
  end
end
