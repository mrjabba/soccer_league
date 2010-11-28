class Game < ActiveRecord::Base
  attr_accessible :playerstats_attributes, :team1_id, :team2_id, :league_id, :init_players
#  after_save :team_rosters_to_playerstats_old
#  after_create :team_rosters_to_playerstats

  belongs_to :visiting_team,
             :class_name => "Team",
             :foreign_key => "team1_id"
  belongs_to :home_team,
             :class_name => "Team",
             :foreign_key => "team2_id"
  belongs_to :league
  
  has_many :playerstats
  #has_many :player_stats, :dependent => :destroy
  # or it this more like this????
  # has_many :players, :through => :player_stats

  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank

  validates :league, :presence => true
  validates :visiting_team, :presence => true
  validates :home_team, :presence => true

  def game_completed=(game_completed)
    self.completed = true if game_completed
  end
  
  
  def team_rosters_to_playerstats
    #after game save, grab roster for each team and populate playerstats for the game
    #this gives the game editor something to work with. 
    #http://stackoverflow.com/questions/1673433/how-to-insert-into-multiple-tables-in-rails
    if self.id = nil
#    if self.init_players?

      teamstat_home = Teamstat.where("league_id = ? AND team_id = ?", self.league.id, self.home_team )
      roster_home = Roster.where("teamstat_id = ?", teamstat_home[0].id)
   
      teamstat_visiting = Teamstat.where("league_id = ? AND team_id = ?", self.league.id, self.visiting_team )
      roster_visiting = Roster.where("teamstat_id = ?", teamstat_visiting[0].id)

      if roster_visiting.size > 0
          roster_visiting.each {|roster| 
#           playerstat = Playerstat.create(:game_id => self.id, :team_id => self.team1_id, :player_id => roster.player.id)
#           we seem to be failing in here, no game.id? maybe not use create but just add objects? better tests...
            playerstat = Playerstat.create!(:game_id => self.id, :team_id => self.team1_id, :player_id => roster.player.id)
           }
        end

      if roster_home.size > 0
        roster_home.each {|roster| 
          playerstat = Playerstat.create!(:game_id => self.id, :team_id => self.team2_id, :player_id => roster.player.id)
         }
      end
    
    else 
      #puts "Game is existing, handling update, no roster pull"
    end
    
  end

end
