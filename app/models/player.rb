class Player < ActiveRecord::Base
  include Auditable
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality, :birth_city, :birth_nation, :name, :fields, :height_feet, :height_inches, :height_meters, :height
  attr_accessor  :height_feet, :height_inches, :height_meters
  before_validation :calc_feet_in_meters
  validate :height_meters_inches_required_together

  has_many :playerstats
  has_many :rosters
  has_many :teamstats, :through => :rosters

  POSITIONS = {"Forward" => "FW", "Midfielder" => "MF", "Defender" => "DF", "Forward/Midfielder" => "FW/MF", "Midfielder/Defender" => "MF/DF", "Goalkeeper" => "GK"}
  
  def name
    "#{self.firstname} #{self.lastname}"
  end
  
  validates :firstname, :presence => true, :length   => { :maximum => 50 }
  validates :lastname, :presence => true, :length   => { :maximum => 50 }

  def fields
    attrs = {}
    attrs[:id] = id
    attrs[:name] = name
    attrs
  end

  def height_meters=(height)
    self.height = height
  end

  def height_meters
    self.height
  end

  validates :firstname, :presence => true, :length   => { :maximum => 50 }
  validates :lastname, :presence => true,  :length   => { :maximum => 50 }
  validates :position, :presence => true
 
  validates_numericality_of :height, :allow_nil => true, :greater_than_or_equal_to => 1
  validates_inclusion_of :position, :in => POSITIONS.values, :message => "%{value} is not a valid position"
 
  def height_meters_inches_required_together
    if !height_feet.blank? && height_inches.blank?
      errors.add(:height_inches, "Inches required when specifying feet")
    end
    if height_feet.blank? && !height_inches.blank?
      errors.add(:height_feet, "Feet required when specifying inches")
    end
  end

  def self.search(search)
    if search
      where('UPPER(lastname) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
 
  private
    def calc_feet_in_meters
      return 0 if height_feet.blank? || height_inches.blank?
      total_inches = BigDecimal.new(height_inches) + (BigDecimal.new(height_feet) * 12)
      self.height =  BigDecimal.new("0.02540") * total_inches
    end  
end