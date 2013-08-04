class MoreVenueFields < ActiveRecord::Migration
  def change
    add_column :venues, :description, :string
    add_column :venues, :directions, :string
    add_column :venues, :address, :string
  end
end
