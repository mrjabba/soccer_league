class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

#  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :roles_mask
#  attr_accessor :roles_mask # in real life this would be an persisted attribute

  include RoleModel
  
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :free
  
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
