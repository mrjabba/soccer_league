class League < ActiveRecord::Base
  attr_accessible :name, :year
  
  has_many :leagueseasons, :dependent => :destroy

  validates :name, :presence => true,
                  :length   => { :maximum => 50 }
  validates :year, :presence => true
  
  
end
