class League < ActiveRecord::Base
  attr_accessible :name, :year, :games_attributes, :created_by_id
  
  has_many :teamstats
  has_many :games

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  
  accepts_nested_attributes_for :games, :reject_if => :all_blank
    
  validates :created_by_id, :presence => true
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_numericality_of :year, :greater_than_or_equal_to => 1800  
end
