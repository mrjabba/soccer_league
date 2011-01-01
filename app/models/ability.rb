class Ability
  include CanCan::Ability

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
  
  def initialize(user)
    user ||= User.new #guest user
  
    #TODO I need to add a "user" to each model
    if user.has_role? :admin
#      puts "user has admin"
      can :manage, :all
    else
#      puts "user doesnt have admin #{user} #{user.roles_mask.to_s}"
      can :read, :all
    end

  end
  
end
