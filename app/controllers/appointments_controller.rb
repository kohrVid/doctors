class AppointmentsController < ApplicationController
	before_action	:who_is_the_current_user, 
			:admin_is_logged_in, 
			:senior_staff_member_is_logged_in, 
			:doctor_or_receptionist_is_logged_in, 
			:privileged_user_is_logged_in

	def index
	end

	def new
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
