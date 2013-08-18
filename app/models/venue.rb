class Venue < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :built, :address, :directions, :description, :coordinate_lat, :coordinate_long, :surface, :playinglocations_attributes

  has_many :playinglocations, :dependent => :destroy
  accepts_nested_attributes_for :playinglocations, :reject_if => :all_blank

  #TODO for address, refactor team address fields to address then re-use
  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }

  def self.fetch_venues_by_name_as_array(query)
    Venue.where("UPPER(name) like UPPER(?)", "%#{query}%").map(&:filter_by_name_hash)
  end

  def self.fetch_venues_for_league(league_id)
    Venue.joins(playinglocations: [:teamstat]).where(teamstats: {league_id: league_id}).order('name')
  end

  def filter_by_name_hash
    {:id => id, :name => name}
  end

  def self.search(search)
    if search
      where('UPPER(name) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
end