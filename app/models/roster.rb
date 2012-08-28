class Roster < ActiveRecord::Base
  include Auditable
  attr_accessible :teamstat_id, :person_id, :position, :jersey_number

  belongs_to :teamstat
  belongs_to :person

  #FIXME created_by not being updated now that we go through teamstats_controller.
  validates :teamstat_id, :presence => true
  validates :person_id, :presence => true

  def self.roster_for_team(teamstat_id)
    where("teamstat_id = ?", teamstat_id)
  end
end