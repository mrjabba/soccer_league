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

=begin
      can :create, Player
      can :update, Player do |player|
#     player.user == user
          player.try(:user) == user #allow edit if you own it
#          player.try(:user) == user || user.role?(:moderator) #self edit or a moderator
        end
        if user.role(:author)
          can :create, Player
          can :update, Player do |player|
            player.try(:user) == user
          end
        end
=end
  
end
