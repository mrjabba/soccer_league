class Roster < ActiveRecord::Base
  include Auditable
  attr_accessible :teamstat_id, :player_id

  belongs_to :teamstat
  belongs_to :player

  #FIXME created_by not being updated now that we go through teamstats_controller.
  validates :teamstat_id, :presence => true
  validates :player_id, :presence => true
end
