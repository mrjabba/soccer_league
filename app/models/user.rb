class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  
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
