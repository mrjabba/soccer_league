class Team < ActiveRecord::Base
  attr_accessible :name, :address1
  
  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true

end
