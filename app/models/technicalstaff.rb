class Technicalstaff < ActiveRecord::Base
  include Auditable
  attr_accessible :teamstat_id, :person_id, :role
  belongs_to :teamstat
  belongs_to :person
  validates :teamstat_id, :presence => true
  validates :person_id, :presence => true
end