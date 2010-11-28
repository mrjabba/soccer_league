class Playerstat < ActiveRecord::Base
  attr_accessible :jersey_number, :goals, :assists, :shots, :fouls, :yellow_cards, :red_cards, :minutes, :saves, :game_id, :player_id, :team_id
  before_validation :init_stats

  belongs_to :player
  belongs_to :team
  belongs_to :game
  
  def init_stats
    #init valus to 0 if nil. this is too long. find a better "ruby" way to handle this
    if jersey_number.blank?
      self.jersey_number = 0
    end
    if goals.blank?
      self.goals = 0
    end
    if assists.blank?
      self.assists = 0
    end
    if shots.blank?
      self.shots = 0
    end
    if fouls.blank?
      self.fouls = 0
    end
    if yellow_cards.blank?
      self.yellow_cards = 0
    end
    if red_cards.blank?
      self.red_cards = 0
    end
    if minutes.blank?
      self.minutes = 0
    end
    if saves.blank?
      self.saves = 0
    end
  end
    
end
