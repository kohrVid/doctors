class DoctorsController < ApplicationController
	load_and_authorize_resource
	def index
		@doctors = Doctor.all.where(doctor: true)
	end

	def new
		@doctor = Doctor.new
		@doctor.build_address
	end

	def create
		@doctor = Doctor.new(doctor_params)
		@object = @doctor
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
		@object = @doctor
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


	private
		def doctor_params
			params.require(:doctor).permit(:title, :first_name, :middle_name, :last_name, :dob, :biography, :phone, :username, :address, :email, :password, :password_confirmation, :admin, :doctor, :doctor, :receptionist)
		end
end
