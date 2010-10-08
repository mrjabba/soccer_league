class Team < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :phone, :website, :email

  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true

  has_one    :teamstat

end
