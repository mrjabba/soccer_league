class Team < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :country, :phone, :website, :email

  phone_regex = /^[\(\)0-9\- \+\.]{10,20}$/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true

  validates :phone, :format => {:with => phone_regex},
    :allow_blank => true

  validates :email, :format => {:with => email_regex},
    :allow_blank => true

  has_one    :teamstat
  has_one    :playerstat

  #TODO relationship to game?
  

end
