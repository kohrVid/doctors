class DoctorsController < ApplicationController
	load_and_authorize_resource
	before_action	:who_is_the_current_user, 
			:admin_is_logged_in, 
			:senior_staff_member_is_logged_in, 
			:doctor_or_receptionist_is_logged_in, 
			:privileged_user_is_logged_in

	def index
		@doctors = Doctor.all.where(doctor: true)
	end

	def new
		@doctor = Doctor.new
		@doctor.build_address
	end

	def create
		@doctor = Doctor.new(doctor_params)
		if @doctor.save
		#	@doctor.send_activation_email
		#	flash[:notice] = "Please check your email to activate your account"
			redirect_to root_url 
		else
			render :new
		end
	end

	def show
		@doctor = Doctor.where(doctor: true).find(params[:id])
	end

	def edit
		@doctor = Doctor.where(doctor: true).find(params[:id])
	end

	def update
		@doctor = Doctor.where(doctor: true).find(params[:id])
		if @doctor.update_attributes(doctor_params)
			flash[:success] = "Profile updated"
			redirect_to @doctor
		else
			flash.now[:error] = "Unable to update profile"
			render :edit
		end
	end

	def destroy
		Doctor.where(doctor: true).find(params[:id]).destroy
		flash[:success] = "Doctor deleted"
		redirect_to doctors_url
	end

	def calendar
		@doctor = Doctor.where(doctor: true).find(params[:id])
		@appointments = Appointment.where(doctor_id: @doctor.id)
	end


	private
		def doctor_params
			params.require(:doctor).permit(:title, :first_name, 
						       :middle_name, :last_name, 
						       :dob, :biography, :phone, 
						       :username, :address, :email, 
						       :password, :password_confirmation, 
						       :admin, :doctor, :doctor, 
						       :receptionist, :approved, :locked)
		end
end
