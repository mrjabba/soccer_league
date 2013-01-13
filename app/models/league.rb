class League < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :to_year, :from_year, :games_attributes, :organization_id, :supports_games, :teamstats_attributes, :leaguezones_attributes

  has_many :games, :dependent => :destroy
  has_many :leaguezones, :dependent => :destroy
  has_many :teamstats, :dependent => :destroy
  belongs_to :organization

  accepts_nested_attributes_for :games, :reject_if => :all_blank
  accepts_nested_attributes_for :leaguezones, :reject_if => :all_blank
  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates_numericality_of :to_year, :greater_than_or_equal_to => 1800
  validates_numericality_of :from_year, :greater_than_or_equal_to => 1800
  validates :organization_id, :presence => true

  def games_exist
    Game.where(:league_id => id).size > 0
  end

  def self.search(search)
    if search
      where('UPPER(name) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
end
