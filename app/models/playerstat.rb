class Playerstat < ActiveRecord::Base
  attr_accessible :goals, :assists, :shots, :fouls, :yellow_cards, :red_cards, :minutes, :saves

  belongs_to :player
  
  validates :goals, :presence => true
  
  
end
