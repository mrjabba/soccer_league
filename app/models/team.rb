class Team < ActiveRecord::Base
  include Auditable
  attr_accessible :name, :address1, :address2, :city, :state, :zip, :country, :phone, :website, :email, :avatar, :avatar_delete

  phone_regex = /^[\(\)0-9\- \+\.]{10,20}$/
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length   => { :maximum => 50 }, :uniqueness => { :case_sensitive => false }
  validates :address1, :presence => true
  validates :phone, :format => {:with => phone_regex}, :allow_blank => true
  validates :email, :format => {:with => email_regex}, :allow_blank => true
  validates_format_of :avatar_file_name, :with => %r{\.(jpg|gif|png)$}i, :allow_nil=> true, :message => "File must be an image of type (jpg,gif,png)"
  validates_attachment :avatar, :size => { :in => 0..740.kilobytes }

  has_many :teamstats
  has_one :playerstat

  has_attached_file :avatar, styles: {thumb: '100x100>', medium: '300x300>'}

  before_save :destroy_avatar?

  #disable this until we get this working on heroku.
  process_in_background :avatar if Rails.env != 'production'

  def self.fetch_teams_by_name_as_array(query)
    Team.where("UPPER(name) like UPPER(?)", "%#{query}%").map(&:filter_by_name_hash)
  end

  def filter_by_name_hash
    {:id => id, :name => name}
  end

  #TODO relationship to game?
  def self.search(search)
    if search
      where('UPPER(name) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end

  def avatar_delete
    @avatar_delete ||= "0"
  end

  def avatar_delete=(value)
    @avatar_delete = value
  end

  def destroy_avatar?
    self.avatar.clear if @avatar_delete == "1" && !avatar.dirty?
  end
end
