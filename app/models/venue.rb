class Venue < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :built, :coordinates, :surface, :playinglocations_attributes

  has_many :playinglocations, :dependent => :destroy
  accepts_nested_attributes_for :playinglocations, :reject_if => :all_blank

  #TODO for address, refactor team address fields to address then re-use
  validates :name, :presence => true,
                  :length   => { :maximum => 50 },
                  :uniqueness => { :case_sensitive => false }

  def self.search(search)
    if search
      where('UPPER(name) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
end