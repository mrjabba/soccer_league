class Game < ActiveRecord::Base
  include Auditable
  attr_accessible :playerstats_attributes, :teamstat1_id, :teamstat2_id, :league_id, :visiting_team_goals, :home_team_goals, :completed
  before_create :team_rosters_to_playerstats
  before_update :update_game
  before_destroy :revert_teamstat

  belongs_to :visiting_team,
             :class_name => "Teamstat",
             :foreign_key => "teamstat1_id"
  belongs_to :home_team,
             :class_name => "Teamstat",
             :foreign_key => "teamstat2_id"
  belongs_to :league
  has_many :playerstats, :dependent => :destroy
  validates_associated :playerstats #is this working?
  
  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank

  validates :league, :presence => true
  validates :visiting_team, :presence => true
  validates :home_team, :presence => true

  validate :opposing_teams_must_be_different

  def opposing_teams_must_be_different
    errors.add(:visiting_team, "must be different from Home team") if teamstat1_id == teamstat2_id
  end  

  def game_completed=(game_completed)
    self.completed = true if game_completed
  end
  
  def visiting_team_goals
    calculate_goals(self.teamstat1_id)
  end
 
  def home_team_goals
    calculate_goals(self.teamstat2_id)
  end

  def home_team_name
    home_team.team.name
  end

  def visiting_team_name
    visiting_team.team.name
  end

  private
    
    def calculate_goals(team_value)
      goals = 0
      
      self.playerstats.each {|ps| 
        if ps.teamstat_id == team_value
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
        teamstat_home = self.home_team
        teamstat_visiting = self.visiting_team
        if self.home_team_goals > self.visiting_team_goals
          #TODO check to see if these are zeroes or not?
          teamstat_home.wins -= 1
          teamstat_visiting.losses -= 1
        elsif self.home_team_goals < self.visiting_team_goals
          teamstat_visiting.wins -= 1
          teamstat_home.losses -= 1
        else 
          teamstat_home.ties -= 1
          teamstat_visiting.ties -= 1
        end

        #FIXME doesnt seem to work when marking game complete + saving at same time. separate transactions? (also has to be a tie?)
        teamstat_home.goals_for -= home_team_goals
        teamstat_visiting.goals_for -= visiting_team_goals
        teamstat_home.goals_against -= visiting_team_goals
        teamstat_visiting.goals_against -= home_team_goals

        teamstat_home.save!
        teamstat_visiting.save!
      end
    end
  
    def update_game
      if self.completed?
        teamstat_home = self.home_team
        teamstat_visiting = self.visiting_team
        if self.home_team_goals > self.visiting_team_goals
          teamstat_home.wins += 1
          teamstat_visiting.losses += 1
        elsif self.home_team_goals < self.visiting_team_goals
          teamstat_visiting.wins += 1
          teamstat_home.losses += 1
        else 
          teamstat_home.ties += 1
          teamstat_visiting.ties += 1
        end

        teamstat_home.goals_for += self.home_team_goals
        teamstat_visiting.goals_for += self.visiting_team_goals
        teamstat_home.goals_against += self.visiting_team_goals
        teamstat_visiting.goals_against += self.home_team_goals

        teamstat_home.save!
        teamstat_visiting.save!
      end
    end
    
    def team_rosters_to_playerstats
      #after game save, grab roster for each team and populate playerstats for the game
      #this gives the game editor something to work with.
      #http://stackoverflow.com/questions/1673433/how-to-insert-into-multiple-tables-in-rails
        teamstat_home = self.home_team
        teamstat_visiting = self.visiting_team
        roster_home = roster_for_team(teamstat_home)
        if roster_home.size > 0
          roster_home.each {|roster|
            self.playerstats.build(:game_id => self.id, :teamstat_id => self.teamstat2_id, :person_id => roster.person.id,
                                   :created_by_id => created_by_id, :updated_by_id => updated_by_id)
          }
        end

        roster_visiting = roster_for_team(teamstat_visiting)
        if roster_visiting.size > 0
            roster_visiting.each {|roster|
              self.playerstats.build(:game_id => self.id, :teamstat_id => self.teamstat1_id, :person_id => roster.person.id,
                                     :created_by_id => created_by_id, :updated_by_id => updated_by_id)
            }
        end
    end

    def roster_for_team(teamstat_id)
      Roster.roster_for_team(teamstat_id)
    end
end