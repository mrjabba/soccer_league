class AddToFromYearsToLeague < ActiveRecord::Migration
  def up
    rename_column :leagues, :year, :from_year
    add_column :leagues, :to_year, :integer
  end

  def down
    rename_column :leagues, :from_year, :year
    remove_column :leagues, :to_year
  end
end
