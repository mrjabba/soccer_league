class League < ActiveRecord::Base
#  attr_accessible :name, :year, :teamstats_attributes, :games_attributes
  attr_accessible :name, :year, :games_attributes
  
  has_many :teamstats
  has_many :games
  
#  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank
  accepts_nested_attributes_for :games, :reject_if => :all_blank
    
  validates :name, :presence => true,
                  :length   => { :maximum => 50 }
  validates :year, :presence => true
  
end
