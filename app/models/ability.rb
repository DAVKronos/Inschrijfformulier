class Ability
  include CanCan::Ability

  def initialize(participant)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    participant ||= Participant.new
      if participant.admin?
        can :read, :all
        can [:home], [Entry]
        can :manage, [Entry] , :participant_id => participant.id
      else
        can :read, :all
        can [:home], [Entry]
        cannot :read, [Entry]
        cannot :read, [Day]
        cannot :read, [EventParticipation]
        cannot :read, [VolunteerDay]
        can :manage, [Entry] , :participant_id => participant.id
        cannot :index, [Entry]
      end
  end
end
