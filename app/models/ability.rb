class Ability
  include CanCan::Ability

  def initialize(user)

    if user
      can :manage, :all
    else
      can :read,   :main
    end

  end

end