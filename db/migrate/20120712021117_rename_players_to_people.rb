class RenamePlayersToPeople < ActiveRecord::Migration
  def self.up
    rename_table :players, :people
    rename_column(:playerstats, :player_id, :person_id)
    rename_column(:rosters, :player_id, :person_id)

    #TODO renames. do this specifically and by case
    #DONE 1 rename players to people
    #DONE 2 rename player to person
    #DONE 3 rename Players to people (if that exists)
    #DONE 4 rename Player to Person (should be for model name)
    #WIP  5 need to rename all player_id cols to person_id
  end

  def self.down
    rename_table :people, :players
  end
end
