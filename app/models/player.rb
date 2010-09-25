class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true

end
