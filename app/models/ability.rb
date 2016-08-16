class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when :admin
      can :manage, :all
    when :user
      can :read, :all
    else
      can :manage, :all
    end
  end
end
