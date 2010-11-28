class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality, :previous_club
  #TODO remove previous_club. that is time dependent. we can calculate that based on playerstat.team.name or roster?, etc

  has_many :playerstats
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true
end
