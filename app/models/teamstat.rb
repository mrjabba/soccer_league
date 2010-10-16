class Teamstat < ActiveRecord::Base
  attr_accessible :wins, :losses, :ties, :goals_for, :goals_against, :team_id

  #should we just initialize our numbers to zero so we can make editing easier?
  

  validates :wins, :presence => true
  validates :losses, :presence => true
  validates :ties, :presence => true
  validates :goals_for, :presence => true
  validates :goals_against, :presence => true
  validates :games_played, :presence => true

  #validates :league_id, :presence => true
  validates :team_id, :presence => true

  belongs_to :league
  belongs_to :team

  def points
    #TODO do we want to make this formula configurable? tournaments may choose to use a diff calculation on points?
    points = wins * 3 + ties
  end 

  def games_played
    if wins.blank? or losses.blank? or ties.blank?
      games_played = 0
    else
      games_played = wins + losses + ties
    end    
  end 

end
