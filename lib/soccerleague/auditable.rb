module Auditable
  def self.included(base)
    base.attr_accessible :created_by_id, :updated_by_id
    base.belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
    base.belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
    base.validates :created_by_id, :presence => true
    base.validates :updated_by_id, :presence => true
  end
end