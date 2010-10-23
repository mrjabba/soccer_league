class Playerstat < ActiveRecord::Base
#  attr_accessible :jersey_number, :goals, :assists, :shots, :fouls, :yellow_cards, :red_cards, :minutes, :saves, :teamstat_id
  attr_accessible :jersey_number, :goals, :assists, :shots, :fouls, :yellow_cards, :red_cards, :minutes, :saves, :teamstat_id, :match_id

  belongs_to :player
  belongs_to :teamstat
  
  belongs_to :match

  
  validates :goals, :presence => true
  
  
end
