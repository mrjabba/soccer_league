class AddStyleToLeaguezones < ActiveRecord::MigrationActiveRecord::Migration
  def change
    add_column :leaguezones, :style, :string
  end
end
