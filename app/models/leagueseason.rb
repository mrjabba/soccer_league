class Leagueseason < ActiveRecord::Base
#  attr_accessible :team_id, :league_id
  #are these keys really accessible????
  
  validates :team_id, :presence => true
  validates :league_id, :presence => true
  
  
  belongs_to :league
  has_many :teamstats, :dependent => :destroy

  belongs_to :team
  
end
