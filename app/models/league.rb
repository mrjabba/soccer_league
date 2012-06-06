class League < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :year, :games_attributes, :organization_id, :supports_games, :teamstats_attributes

  has_many :teamstats
  has_many :games
  belongs_to :organization
  
  accepts_nested_attributes_for :games, :reject_if => :all_blank
  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_numericality_of :year, :greater_than_or_equal_to => 1800
  validates :organization_id, :presence => true

  def games_exist
    Game.where(:league_id => id).size > 0
  end
end
