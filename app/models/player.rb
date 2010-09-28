class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :jersey_number, :birth_date, :nationality, :previous_club
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true

end
