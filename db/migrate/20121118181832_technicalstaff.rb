class Technicalstaff < ActiveRecord::Migration
  def up
    create_table :technicalstaffs do |t|
      t.integer :teamstat_id
      t.integer :person_id
      t.string :role
      t.integer :updated_by_id
      t.integer :created_by_id

      t.timestamps
    end
  end

  def down
    drop_table :technicalstaffs
  end
end
