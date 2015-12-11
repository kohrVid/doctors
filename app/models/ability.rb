class Ability
  include CanCan::Ability
  def initialize(user)
       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
	 cannot :destroy, User, id: user.id
       elsif user.doctor?
         [:create, :read, :update].each do |action|
		 can action, Patient
	 end
	 [:read, :update].each do |action|
		 can action, Doctor, id: user.id
		 can action, User, id: user.id
	 end
	 can :read, User
	 can :manage, Page
	 cannot :create, Doctor
	 cannot :destroy, User
       elsif user.receptionist?
	 [:read, :update].each do |action|
		 can action, Patient
		 can action, User, id: user.id
	 end
	 can :create, Patient
	 can :read, User
         can :read, Page
	 [:update, :destroy].each do |action|
	 	cannot action, Doctor
	 	cannot action, Page
	 end
	 cannot :destroy, User
       elsif user.patient?
	 [:update, :read].each do |action|
		 can action, Patient, id: user.id
		 can action, User, id: user.id
	 end
	 can :create, Patient
         can :read, Page
	 can :read, Doctor
	 [:create, :update, :destroy].each do |action|
		 cannot action, Doctor
	 end
	 [:index, :destroy].each do |action|
		 cannot action, User.all.where(doctor: false)
		 cannot action, Patient
	 end
	 [:read, :update].each do |action|
		 cannot action, User, id: !user.id
		 cannot action, Patient, id: !user.id
	 end
       else
	 [:read, :index, :show].each do |action|
		can action, Doctor
	 end
	 [:index, :show, :read].each do |action|
		 can action, Page
	 end
	 can :create, Patient
	 [:index, :read, :destroy].each do |action|
		 cannot action, Patient
	 end
	 [:create, :update, :destroy].each do |action|
		 cannot action, Doctor
	 end
	 [:index, :update, :destroy].each do |action|
		 cannot action, User.all.where(doctor: false)
	 end
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
