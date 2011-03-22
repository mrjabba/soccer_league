class Roster < ActiveRecord::Base
  attr_accessible :teamstat_id, :player_id, :created_by_id

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"

  belongs_to :teamstat
  belongs_to :player

  #FIXME created_by not being updated now that we go through teamstats_controller.
#  validates :created_by_id, :presence => true
  validates :teamstat_id, :presence => true
  validates :player_id, :presence => true

end
