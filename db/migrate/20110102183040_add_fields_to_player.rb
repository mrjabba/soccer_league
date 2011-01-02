class AddFieldsToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :birth_city, :string
    add_column :players, :birth_nation, :string
    add_column :players, :height, :integer
  end

  def self.down
    remove_column :players, :height
    remove_column :players, :birth_nation
    remove_column :players, :birth_city
  end
end
