class League < ActiveRecord::Base
  attr_accessible :name, :year, :teamstats_attributes, :matches_attributes
  
#  has_many :teamstats, :dependent => :destroy
  has_many :teamstats
  has_many :matches
  
  #accepts_nested_attributes_for :teamstats, :allow_destroy => true
  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank
  #accepts_nested_attributes_for :teamstats, :reject_if => lambda { |a| a[:wins].blank? }, :allow_destroy => true

  accepts_nested_attributes_for :matches, :reject_if => :all_blank
    
  validates :name, :presence => true,
                  :length   => { :maximum => 50 }
  validates :year, :presence => true
  
end
