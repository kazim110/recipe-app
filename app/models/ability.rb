class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Recipe
      can :create, Food
      can :destory, Recipe, user_id: user.id
      can :destory, Food, user_id: user.id
    end
  end
end
