class AddStyleToLeaguezones < ActiveRecord::Migration
  def change
    add_column :leaguezones, :style, :string
  end
end
