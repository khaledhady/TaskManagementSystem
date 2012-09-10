class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :admin
        can :manage, Project do |project|
          user.projects.include? project
        end
        can :create, Project
        can :manage, User
    else
        can :read, Project do |project|
          user.projects.include? project
        end
    end

  end
end