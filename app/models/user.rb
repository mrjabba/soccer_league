class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :roles_mask, :perms, :free_sign_up, :with_role
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
  
  validates :username, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => { :case_sensitive => false}

  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
