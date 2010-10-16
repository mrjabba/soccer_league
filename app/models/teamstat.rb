class Teamstat < ActiveRecord::Base
  attr_accessible :points, :wins, :losses, :ties, :goals_for, :goals_against, :games_played, :team_id

=begin
  validates :wins, :presence => true
  validates :losses, :presence => true
  validates :ties, :presence => true
  validates :goals_for, :presence => true
  validates :goals_against, :presence => true
  validates :games_played, :presence => true
=end
  validates :points, :presence => true
  #validates :league_id, :presence => true
  validates :team_id, :presence => true

  belongs_to :league
  belongs_to :team

end
