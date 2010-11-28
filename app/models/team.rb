class Team < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :phone, :website, :email
  #TODO add country as a field
  #TODO validate phone is a valid phone format?
  #TODO validate email is a valid email format?

  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true

  has_one    :teamstat
  has_one    :playerstat
  #TODO relationship to game?

end
