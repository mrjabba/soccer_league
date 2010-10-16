class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality, :previous_club, :playerstats_attributes

  has_many :playerstats

  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true

  #TODO remove previous_club. that is time dependent. we can calculate that based on playerstat.team.name, etc

end
