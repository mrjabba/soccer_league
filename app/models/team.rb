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

  has_one    :teamstat #I think I would like teams to have_many teamstats (belonging to multiple leagues)...can we do this?
  has_one    :playerstat

  def league
    teamstat.league if teamstat != nil
  end

  #TODO relationship to game?
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end