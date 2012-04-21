module Auditable
  def self.included(base)
    base.attr_accessible :created_by_id, :updated_by_id
    base.belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
    base.belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
    base.validates :created_by_id, :presence => true
    base.validates :updated_by_id, :presence => true
  end

  def creator_name
    created_by ? created_by.username : "unknown"
  end

  def creator_id
    created_by ? created_by.id : "unknown"
  end

  def updator_name
    updated_by ? updated_by.username : "unknown"
  end

  def updator_id
    updated_by ? updated_by.id : "unknown"
  end
end