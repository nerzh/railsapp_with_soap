class Ability
  include CanCan::Ability

  def initialize(user)

    if user
      can :manage, :all
    else
      can :manage,   :main
    end

  end

end