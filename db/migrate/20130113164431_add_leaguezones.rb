class AddLeaguezones < ActiveRecord::Migration
  def up
    create_table :leaguezones do |t|
      t.string :name
      t.string :description
      t.integer :league_id
      t.integer :start_rank
      t.integer :end_rank
      t.integer :updated_by_id
      t.integer :created_by_id
      t.timestamps
    end
  end

  def down
    drop_table :leaguezones
  end
end
