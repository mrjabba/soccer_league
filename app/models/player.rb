class Player < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality, :birth_city, :birth_nation, :height, :created_by_id, :name, :fields

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  has_many :playerstats
  has_many :rosters
  has_many :teamstats, :through => :rosters

  POSITIONS = {"Forward" => "FW", "Midfielder" => "MF", "Defender" => "DF", "Forward/Midfielder" => "FW/MF", "Midfielder/Defender" => "MF/DF", "Goalkeeper" => "GK"}
  
  def name
    "#{self.firstname} #{self.lastname}"
  end  
  
  validates :created_by_id, :presence => true
  validates :firstname, :presence => true, :length   => { :maximum => 50 }
  validates :lastname, :presence => true, :length   => { :maximum => 50 }
  validates :position, :presence => true
 
  validates_numericality_of :height, :allow_nil => true, :greater_than_or_equal_to => 1
  validates_inclusion_of :position, :in => POSITIONS.values, :message => "%{value} is not a valid position"
  
  def self.search(search)
    if search
      where('lastname LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
