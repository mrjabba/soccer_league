class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :jersey_number, :birth_date, :nationality, :previous_club, :playerstats_attributes

  has_many :playerstats

  accepts_nested_attributes_for :playerstats, :reject_if => :all_blank
  
  validates :firstname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :lastname, :presence => true,
                  :length   => { :maximum => 50 }
  validates :position, :presence => true

end
