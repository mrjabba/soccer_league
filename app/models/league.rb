class League < ActiveRecord::Base
  attr_accessible :name, :year, :teamstats_attributes
  
#  has_many :teamstats, :dependent => :destroy
  has_many :teamstats
  #accepts_nested_attributes_for :teamstats, :allow_destroy => true
  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank
  #accepts_nested_attributes_for :teamstats, :reject_if => lambda { |a| a[:wins].blank? }, :allow_destroy => true
    
  validates :name, :presence => true,
                  :length   => { :maximum => 50 }
  validates :year, :presence => true
  
end
