# Playing Locations
# You should be able to add a venue (field/stadium) option.
# However, you need to maintain the relationship between a team in a season (teamstat)
# and their available venues. Some teams share a field one year and have their own, the next
# This model relationship lets you track venues over time for a team.
class Playinglocation < ActiveRecord::Base
  include Auditable
  attr_accessible :teamstat_id, :venue_id
  belongs_to :teamstat
  belongs_to :venue
  validates :teamstat_id, :presence => true
  validates :venue_id, :presence => true
end