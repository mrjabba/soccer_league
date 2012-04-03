class Organization < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :founded, :website, :leagues_attributes
  has_many :leagues, :dependent => :destroy

  accepts_nested_attributes_for :leagues, :reject_if => :all_blank

  validates :name, :presence => true, :length => { :maximum => 255 }
  validates_numericality_of :founded, :greater_than_or_equal_to => 1800, :allow_blank => true
end