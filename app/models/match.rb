class Match < ActiveRecord::Base
  attr_accessible :playerstats_attributes


  belongs_to :visiting_team,
             :class_name => "Team",
             :foreign_key => "team1_id"
  belongs_to :home_team,
             :class_name => "Team",
             :foreign_key => "team2_id"
  belongs_to :league
  
  has_many :player_stats
  #has_many :player_stats, :dependent => :destroy
  # or it this more like this????
  # has_many :players, :through => :player_stats

  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank

end
