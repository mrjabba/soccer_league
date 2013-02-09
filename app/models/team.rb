class Team < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :country, :phone, :website, :email

  phone_regex = /^[\(\)0-9\- \+\.]{10,20}$/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true

  validates :phone, :format => {:with => phone_regex}, :allow_blank => true

  validates :email, :format => {:with => email_regex}, :allow_blank => true

  has_many    :teamstats
  has_one    :playerstat

  def self.fetch_teams_by_name_for_league_as_array(league_id, query)
    Team.joins(:teamstats).where("league_id = ? AND UPPER(name) like UPPER(?)", "#{league_id}", "%#{query}%").map(&:filter_by_name_hash)
  end

  def self.fetch_teams_by_name_as_array(query)
    Team.where("UPPER(name) like UPPER(?)", "%#{query}%").map(&:filter_by_name_hash)
  end

  def filter_by_name_hash
    {:id => id, :name => name}
  end

  #TODO relationship to game?
  def self.search(search)
    if search
      where('UPPER(name) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
end