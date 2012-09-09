class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :admin
        can :manage, :all
    else
        can :read, Project do |project|
            user.tasks.include? project
        end
    end

  end
end