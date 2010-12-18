class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality

  has_many :playerstats
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true
end
