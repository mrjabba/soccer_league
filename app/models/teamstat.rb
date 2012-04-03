class Teamstat < ActiveRecord::Base
  include Auditable
  attr_accessible :wins, :losses, :ties, :goals_for, :goals_against, :team_id, :league_id, :player_tokens 
  attr_reader :player_tokens
  before_validation :init_stats
  
  belongs_to :league
  belongs_to :team
  has_many :rosters
  has_many :players, :through => :rosters
  delegate :name, :to => :team, :prefix => true
  
  validates :league_id, :presence => true
  validates :team_id, :presence => true

  def player_tokens=(ids)
    self.player_ids = ids.split(",")
  end

  #TODO ensure these are whole numbers?
  validates_numericality_of :wins, :greater_than_or_equal_to => 0
  validates_numericality_of :losses, :greater_than_or_equal_to => 0
  validates_numericality_of :ties, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_for, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_against, :greater_than_or_equal_to => 0

  def self.teamstat_for_league(league_id, team_id)
    team_stat = where("league_id = ? AND team_id = ?", league_id, team_id )
    team_stat.first
  end

  def points
    #TODO do we want to make this formula configurable? tournaments may choose to use a diff calculation on points?
    points = wins * 3 + ties
  end 
  
  def record
    "#{wins}-#{losses}-#{ties}"
  end
  
  def games_played
    if wins.blank? or losses.blank? or ties.blank?
      games_played = 0
    else
      games_played = wins + losses + ties
    end    
  end 

  def init_stats
    #init valus to 0 if nil. this is too long. find a better "ruby" way to handle this
    if wins.blank?
      self.wins = 0
    end
    if losses.blank?
      self.losses = 0
    end
    if ties.blank?
      self.ties = 0
    end
    if goals_for.blank?
      self.goals_for = 0
    end
    if goals_against.blank?
      self.goals_against = 0
    end
    self.games_played = games_played()
    self.points = points()    
  end
end