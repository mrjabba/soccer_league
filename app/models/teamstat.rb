class Teamstat < ActiveRecord::Base
  include Auditable
  attr_accessible :rosters_attributes, :points, :wins, :losses, :ties, :goals_for, :goals_against, :team_id, :league_id,
                  :person_tokens, :playinglocations_attributes, :technicalstaffs_attributes
  attr_accessor :person_tokens
  before_validation :init_stats
  before_create :convert_person_ids_to_roster_items

  belongs_to :league
  belongs_to :team

  has_many :rosters, :dependent => :destroy
  has_many :playinglocations, :dependent => :destroy
  has_many :technicalstaffs, :dependent => :destroy
  has_many :people, :through => :rosters

  accepts_nested_attributes_for :rosters, :reject_if => :all_blank
  accepts_nested_attributes_for :playinglocations, :reject_if => :all_blank
  accepts_nested_attributes_for :technicalstaffs, :reject_if => :all_blank

  delegate :name, :to => :team, :prefix => true

  validates :league_id, :presence => true
  validates :team_id, :presence => true

  def self.fetch_league_table(league_id)
    Teamstat.includes([:team]).find_all_by_league_id(league_id).sort!{|a,b| b.calculate_points <=> a.calculate_points}
  end

  #TODO ensure these are whole numbers?
  validates_numericality_of :wins, :greater_than_or_equal_to => 0
  validates_numericality_of :losses, :greater_than_or_equal_to => 0
  validates_numericality_of :ties, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_for, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_against, :greater_than_or_equal_to => 0

  def team_name
    team.name
  end

  def self.fetch_teams_by_name_for_league_as_array(league_id, query)
    Teamstat.joins(:team).where("league_id = ? AND UPPER(name) like UPPER(?)", "#{league_id}", "%#{query}%").map(&:filter_by_team_name_hash)
  end

  def filter_by_team_name_hash
    {:id => id, :name => team.name}
  end

  def self.teamstat_for_league(league_id, team_id)
    team_stat = where("league_id = ? AND team_id = ?", league_id, team_id )
    team_stat.first
  end

  def calculate_points
    #TODO do we want to make this formula configurable? tournaments may choose to use a diff calculation on points?
    league.calc_points? ? wins * 3 + ties : points
  end
  
  def record
    "#{wins}-#{losses}-#{ties}"
  end
  
  def games_played
    if wins.blank? or losses.blank? or ties.blank?
      0
    else
      wins + losses + ties
    end
  end

  private

  def convert_person_ids_to_roster_items
    unless person_tokens.blank?
      self.rosters.clear
      person_tokens.split(",").each { |person_id|
        self.rosters.build(:person_id => person_id,
                           :created_by_id => created_by_id, :updated_by_id => updated_by_id)
      }
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
    self.games_played = games_played
    self.points = points
  end
end