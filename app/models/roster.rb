class Roster < ActiveRecord::Base
  attr_accessible :teamstat_id, :player_id

  belongs_to :teamstat
  belongs_to :player

end
