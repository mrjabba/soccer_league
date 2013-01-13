## League Zones
## You should be able to define zones for a league's stats to describe
## things like promotion, relegation or qualification for tournaments
class Leaguezone < ActiveRecord::Base
  include Auditable
  attr_accessible :league_id, :name, :description, :start_rank, :end_rank, :style
  belongs_to :league
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :style, :presence => true, :length => { :maximum => 50 }
  validates :start_rank, :presence => true
  validates :end_rank, :presence => true
  validates_numericality_of :start_rank, :greater_than_or_equal_to => 1
  validates_numericality_of :end_rank, :greater_than_or_equal_to => 1
  validates :league_id, :presence => true

  STYLES = {"" => "", "zone_up" => "zone_up", "zone_middle" => "zone_middle", "zone_down" => "zone_down"}

  def self.find_zone_by_position(zones, position)
    zones.find {|zone| (zone.start_rank..zone.end_rank).include?(position)}
  end
end
