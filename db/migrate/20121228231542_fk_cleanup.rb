class FkCleanup < ActiveRecord::Migration
  def up
    #one time fix
    #cleaning up some orphaned keys from before we used dependent:destroy, fixed in 3d62f8f867af35b2cc46b1ed9ccb7711086375ed
    execute "DELETE from rosters where teamstat_id in (select distinct r.teamstat_id from rosters r LEFT OUTER JOIN teamstats ts ON (ts.id = r.teamstat_id) where ts.id is null)"
  end

  def down
  end
end
