class Roster < ActiveRecord::Base
  attr_accessible :teamstat_id, :player_id

  belongs_to :teamstat
  belongs_to :player

  validates :teamstat_id, :presence => true
  validates :player_id, :presence => true

end
