class Ability
  include CanCan::Ability
  def initialize(user)
       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
	 cannot :destroy, User, id: user.id
       elsif user.doctor?
         can :manage, Patient
	 can :manage, Page
	 can :read, Doctor
	 can :manage, Doctor, id: user.id
	 can :manage, User, id: user.id
	 can :read, Admin
	 cannot :destroy, User
	 cannot :destroy, Patient
       elsif user.receptionist?
         can :manage, Patient
	 can :manage, User, id: user.id
	 cannot :destroy, User
	 can :read, Admin
         can :read, Page
	 cannot :manage, Page
	 cannot :destroy, User
	 cannot :destroy, Patient
       elsif user.patient?
         can :manage, Patient, id: user.id
         can :manage, User, id: user.id
	 can :create, Patient
	 cannot :destroy, User, id: user.id
	 cannot :destroy, Patient, id: user.id
         can :read, Page
	 [:index, :show, :edit, :destroy].each do |action|
		 cannot action, User
	 end
#	 [:index, :show, :edit, :destroy].each do |action|
#		 cannot action, Patient
#	 end
       else
         can :read, Page
	 can :read, Doctor
	 can :create, Patient
	 cannot :read, Patient
	 [:index, :show, :edit, :destroy].each do |action|
		 cannot action, User
	 end
#	 [:index, :show, :edit, :destroy].each do |action|
#		 cannot action, Patient
#	 end
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
