class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user
  
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all 
      #need to restrict :user read but only that model for guests
    end
  end
end
