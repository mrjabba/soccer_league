class Game < ActiveRecord::Base
  include Auditable
  attr_accessible :playerstats_attributes, :team1_id, :team2_id, :league_id, :visiting_team_goals, :home_team_goals
  before_create :team_rosters_to_playerstats
  before_update :update_game
  before_destroy :revert_teamstat

  belongs_to :visiting_team,
             :class_name => "Team",
             :foreign_key => "team1_id"
  belongs_to :home_team,
             :class_name => "Team",
             :foreign_key => "team2_id"
  belongs_to :league
  
  has_many :playerstats, :dependent => :destroy
  validates_associated :playerstats #is this working?
  
  # or it this more like this????
  # has_many :players, :through => :player_stats

  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank

  validates :league, :presence => true
  validates :visiting_team, :presence => true
  validates :home_team, :presence => true

  validate :opposing_teams_must_be_different

  def opposing_teams_must_be_different
    errors.add(:visiting_team, "must be different from Home team") if team1_id == team2_id
  end  

  def game_completed=(game_completed)
    self.completed = true if game_completed
  end
  
  def visiting_team_goals
    calculate_goals(self.team1_id)
  end
 
  def home_team_goals
    calculate_goals(self.team2_id)
  end

  def game_creator
    created_by ? created_by.username : "unknown"
  end

  private
    
    def calculate_goals(team_value)
      goals = 0
      
      self.playerstats.each {|ps| 
        if ps.team_id == team_value
          goals += ps.goals
        end
      }
      
      if goals != nil
        goals
      else
        0
      end
    end
  
    def revert_teamstat
      #puts "**** revert_teamstat"
      if self.completed?
        teamstat_home = Teamstat.teamstat_for_league(self.league.id, self.home_team )
        teamstat_visiting = Teamstat.teamstat_for_league(self.league.id, self.visiting_team )
        if teamstat_home.size > 0 and teamstat_visiting.size > 0
          if self.home_team_goals > self.visiting_team_goals
            #TODO check to see if these are zeroes or not?
            teamstat_home[0].wins -= 1
            teamstat_visiting[0].losses -= 1
          elsif self.home_team_goals < self.visiting_team_goals
            teamstat_visiting[0].wins -= 1
            teamstat_home[0].losses -= 1
          else 
            teamstat_home[0].ties -= 1
            teamstat_visiting[0].ties -= 1
          end

          #FIXME doesnt seem to work when marking game complete + saving at same time. separate transactions? (also has to be a tie?)
          teamstat_home[0].goals_for -= home_team_goals
          teamstat_visiting[0].goals_for -= visiting_team_goals
          teamstat_home[0].goals_against -= visiting_team_goals
          teamstat_visiting[0].goals_against -= home_team_goals

          teamstat_home[0].save
          teamstat_visiting[0].save
        end
      
      end
          
    end
  
    def update_game
      if self.completed?
        teamstat_home = Teamstat.teamstat_for_league(self.league.id, self.home_team )
        teamstat_visiting = Teamstat.teamstat_for_league(self.league.id, self.visiting_team )
        if teamstat_home.size > 0 and teamstat_visiting.size > 0
          if self.home_team_goals > self.visiting_team_goals
            teamstat_home[0].wins += 1
            teamstat_visiting[0].losses += 1
          elsif self.home_team_goals < self.visiting_team_goals
            teamstat_visiting[0].wins += 1
            teamstat_home[0].losses += 1
          else 
            teamstat_home[0].ties += 1
            teamstat_visiting[0].ties += 1
          end

          teamstat_home[0].goals_for += self.home_team_goals
          teamstat_visiting[0].goals_for += self.visiting_team_goals
          teamstat_home[0].goals_against += self.visiting_team_goals
          teamstat_visiting[0].goals_against += self.home_team_goals

          teamstat_home[0].save
          teamstat_visiting[0].save

        else
          puts "cant update teamstats unless both teams have teamstat records. TODO validation before game is created?"
        end
      end
    end
    
    def team_rosters_to_playerstats
      #after game save, grab roster for each team and populate playerstats for the game
      #this gives the game editor something to work with. 
      #http://stackoverflow.com/questions/1673433/how-to-insert-into-multiple-tables-in-rails
  #    puts "*** running team_rosters_to_playerstats self id"
        teamstat_home = Teamstat.teamstat_for_league(self.league.id, self.home_team )
        teamstat_visiting = Teamstat.teamstat_for_league(self.league.id, self.visiting_team )
        if teamstat_home.size > 0
          roster_home = Roster.where("teamstat_id = ?", teamstat_home[0].id)
          #puts "kmh roster_home #{roster_home.size}"
          if roster_home.size > 0
            roster_home.each {|roster| 
              self.playerstats.build(:game_id => self.id, :team_id => self.team2_id, :player_id => roster.player.id)
             }
          end
        end

        if teamstat_visiting.size > 0
          roster_visiting = Roster.where("teamstat_id = ?", teamstat_visiting[0].id)
          #puts "kmh roster_visiting #{roster_visiting.size}"
          if roster_visiting.size > 0
              roster_visiting.each {|roster| 
                self.playerstats.build(:game_id => self.id, :team_id => self.team1_id, :player_id => roster.player.id)
               }
          end
        end
    end
end