class League < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :year, :games_attributes
  
  has_many :teamstats
  has_many :games
  
  accepts_nested_attributes_for :games, :reject_if => :all_blank
    
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_numericality_of :year, :greater_than_or_equal_to => 1800
end
