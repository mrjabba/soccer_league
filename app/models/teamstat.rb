class Teamstat < ActiveRecord::Base
  attr_accessible :points, :wins, :losses, :ties, :goals_for, :goals_against, :games_played

  validates :points, :presence => true
  validates :wins, :presence => true
  validates :losses, :presence => true
  validates :ties, :presence => true
  validates :goals_for, :presence => true
  validates :goals_against, :presence => true
  validates :games_played, :presence => true
  validates :leagueseason_id, :presence => true

  belongs_to :leagueseason

end
