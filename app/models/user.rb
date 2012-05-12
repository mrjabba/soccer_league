class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :roles_mask, :perms, :free_sign_up, :with_role, :metric
  include RoleModel
  
  scope :with_role, lambda { |role|  where( "roles_mask = #{User.mask_for(role)}" )  }
  
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :free
  
  def perms=(role_names)
    self.roles = []
    role_names.map {|role| self.roles << role}
  end

  def free_sign_up=(activate)
    self.roles << :free unless activate == nil
  end

  METRIC_ENGLISH = {"Metric (meters)" => true, "English (feet)" => false}

  validates :username, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => { :case_sensitive => false}

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a free user with a stub password.
      self.create!(:email => data.email, :username => data.email, :roles_mask => 2, :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
  #TODO handle cancel in view -> cancel_user_registration_path see https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

  def self.search(search)
    if search
      where('UPPER(username) LIKE UPPER(?)', "%#{search}%")
    else
      scoped
    end
  end
end