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
		if @doctor.save
			flash[:success] = "Doctor has been successfully created"
			redirect_to root_url 
		else
			flash.now[:danger] = "Unable to create doctor"
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
		respond_with do |format|
			format.html { render 'calendar' }
		end
	end


	private
		def doctor_params
			params.require(:doctor).permit(:title, :first_name, 
						       :middle_name, :last_name, 
						       :dob, :biography, :phone, 
						       :username, :email, :password,
						       :password_confirmation, :admin,
						       :doctor, :receptionist, :approved,
						       :locked, address_attributes:
						       [:street, :address_line2, :city,
	      						:county, :post_code])
		end
end
