class League < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :to_year, :from_year, :games_attributes, :organization_id, :supports_games, :calc_points,
                  :teamstats_attributes, :leaguezones_attributes,
                  :show_map, :coordinate_lat, :coordinate_long, :zoom_level

  has_many :games, :dependent => :destroy
  has_many :leaguezones, :dependent => :destroy
  has_many :teamstats, :dependent => :destroy
  belongs_to :organization

  accepts_nested_attributes_for :games, :reject_if => :all_blank
  accepts_nested_attributes_for :leaguezones, :reject_if => :all_blank
  accepts_nested_attributes_for :teamstats, :reject_if => :all_blank

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :to_year, :from_year, :presence => true, :length => { :maximum => 50 }
  validates_numericality_of :to_year, :greater_than_or_equal_to => 1800, :only_integer => true
  validates_numericality_of :from_year, :greater_than_or_equal_to => 1800, :only_integer => true
  validates_inclusion_of :to_year, :in => 1800..2500
  validates_inclusion_of :from_year, :in => 1800..2500
  validates_inclusion_of :zoom_level, :in => 0..20
  validates :zoom_level, numericality: { only_integer: true }

  validates :organization_id, :presence => true

  def games_exist?
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
