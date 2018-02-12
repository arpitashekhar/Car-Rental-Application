class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.superadmin_role?
      can :manage, :all
      cannot :show_in_app, :all
      cannot [:destroy, :update], User do |u|   #superadmin cannot update, delete other superadmin
        u != user && u.superadmin_role?
      end
      can :access, :rails_admin # only allow admin users to access Rails Admin
      can :dashboard
    end
    if user.supervisor_role?
      can :manage, :all
      cannot :show_in_app, :all
      cannot [:update, :destroy], User do |u|   # admin cannot update, delete superadmin
        u.superadmin_role?
      end
      cannot [:update], User do |u|   # admin cannot update other admin
        u != user && u.supervisor_role?
      end
      cannot [:destroy], User, id: user.id  # admin cannot delete self
      can :access, :rails_admin
      can :dashboard
    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
