class Ability
	include CanCan::Ability
	def initialize(user)
		user ||= User.new # guest user (not logged in)
		if user.admin?
			can :manage, :all
			can :calendar, Patient
			can :manage, Testimonial
			cannot :destroy, User, id: user.id
		elsif user.doctor?
			[:read, :update, :calendar].each do |action|
				can action, Doctor, id: user.id
				can action, User, id: user.id
			end
			can :read, User
			can :manage, Page
			can :manage, Patient
			can :manage, Testimonial
			can :manage, Appointment
			cannot :create, Doctor
			cannot :destroy, User
		elsif user.receptionist?
			[:read, :update, :calendar].each do |action|
				can action, User, id: user.id
			end
			[:create, :read, :update].each do |action|
				can action, Appointment
			end
			[:bulk_patient_approval, :bulk_patient_approved, :calendar].each do |action|
				can action, Patient
			end
			can :manage, Patient
			can :read, User
			can :read, Page
			can :read, Testimonial
			[:update, :destroy].each do |action|
				cannot action, Doctor
				cannot action, Page
				cannot action, Testimonial
			end
			cannot :index, Testimonial
			cannot :destroy, User
		elsif user.patient?
			[:update, :read, :calendar].each do |action|
				can action, Patient, id: user.id
				can action, User, id: user.id
				can action, Appointment, patient_id: user.id
			end
			[:index, :create].each do |action|
				can action, Appointment
			end
			can :create, Patient
			can :read, Page
			can :read, Doctor
			can :read, Testimonial
			[:create, :update, :destroy, :calendar].each do |action|
				cannot action, Doctor
			end
			[:index, :destroy].each do |action|
				cannot action, User.where(doctor: false)
				cannot action, Patient
			end
			[:read, :update].each do |action|
				cannot action, User, id: !user.id
				cannot action, Patient, id: !user.id
			end
			[:index, :update, :destroy].each do |action|
				cannot action, Testimonial
			end
		else
			[:read, :index, :show].each do |action|
				can action, Page
				can action, Doctor
			end
			can :create, Patient
			can :read, Testimonial
			[:index, :read, :destroy].each do |action|
				cannot action, Patient
			end
			[:create, :update, :destroy, :calendar].each do |action|
				cannot action, Doctor
			end
			[:index, :update, :destroy].each do |action|
				cannot action, Testimonial
				cannot action, User.where(doctor: false)
			end
			[:create, :read, :update, :destroy].each do |action|
				cannot action, Appointment
			end
			cannot :index, Appointment
		end
	end
end
