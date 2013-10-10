class Person < ActiveRecord::Base
  include Auditable
  attr_accessible :firstname, :lastname, :position, :birth_date, :nationality, :birth_city, :birth_nation, :name, :fields, :height_feet, :height_inches, :height_meters, :height, :avatar, :avatar_delete
  attr_accessor  :height_feet, :height_inches, :height_meters
  before_validation :calc_feet_in_meters
  before_save :destroy_avatar?
  validate :height_meters_inches_required_together
  validate :at_least_one_name

  has_many :playerstats, :dependent => :destroy
  has_many :rosters, :dependent => :destroy
  has_many :technicalstaffs, :dependent => :destroy
  has_many :teamstats, :through => :rosters

  POSITIONS = {"" => "", "Forward" => "FW", "Midfielder" => "MF", "Defender" => "DF", "Forward/Midfielder" => "FW/MF", "Midfielder/Defender" => "MF/DF", "Goalkeeper" => "GK"}
  TECHNICAL_ROLES = {"" => "", "President" => "President", "Technical Director" => "Technical Director",
               "Head Coach" => "Head Coach", "Assistant Coach" => "Assistant Coach",
               "Goalkeeper Coach" => "Goalkeeper Coach", "Head Athletic Trainer " => "Head Athletic Trainer",
              "Assistant Athletic Trainer " => "Assistant Athletic Trainer "}

  has_attached_file :avatar,
      styles: {thumb: '100x100>', medium: '300x300>'}

  validates :firstname, :length   => { :maximum => 50 }
  validates :lastname, :length   => { :maximum => 50 }
  validates_numericality_of :height, :allow_nil => true, :greater_than_or_equal_to => 1
  validates_inclusion_of :position, :in => POSITIONS.values, :message => "%{value} is not a valid position",allow_blank: true
  validates_format_of :avatar_file_name, :with => %r{\.(jpg|gif|png)$}i, :allow_nil=> true, :message => "File must be an image of type (jpg,gif,png)"
  validates_attachment :avatar, :size => { :in => 0..740.kilobytes }

  #disable this until we get this working on heroku.
  process_in_background :avatar if Rails.env != 'production'

  def name
    case
    when self.firstname.blank?
      self.lastname
    when self.lastname.blank?
      self.firstname
    else
      "#{self.firstname} #{self.lastname}"
    end
  end

  def self.fetch_people_by_first_name_as_array(query)
    Person.where("UPPER(firstname) like UPPER(?)", "%#{query}%").map(&:filter_by_name_hash)
  end

  def filter_by_name_hash
    {:id => id, :name => name}
  end

  def height_meters=(height)
    self.height = height
  end

  def height_meters
    self.height
  end

  def height_meters_inches_required_together
    if !height_feet.blank? && height_inches.blank?
      errors.add(:height_inches, "Inches required when specifying feet")
    end
    if height_feet.blank? && !height_inches.blank?
      errors.add(:height_feet, "Feet required when specifying inches")
    end
  end

  def avatar_delete
    @avatar_delete ||= "0"
  end

  def avatar_delete=(value)
    @avatar_delete = value
  end

  def self.search(search)
    if search
      where('UPPER(lastname) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
 
  def at_least_one_name
    if (self.firstname.blank? && self.lastname.blank?)
        errors[:base] << ("Please choose at least one name (first or last)")
    end
  end

  private

  def destroy_avatar?
    self.avatar.clear if @avatar_delete == "1" && !avatar.dirty?
  end

  def calc_feet_in_meters
      return 0 if height_feet.blank? || height_inches.blank?
      total_inches = BigDecimal.new(height_inches) + (BigDecimal.new(height_feet) * 12)
      self.height =  BigDecimal.new("0.02540") * total_inches
    end  
end