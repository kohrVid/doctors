class PatientsController < ApplicationController
	load_and_authorize_resource
	def index
		@patients = Patient.all.where(patient: true)
	end

	def new
		@patient = Patient.new
		@patient.build_address
	end

	def create
		@patient = Patient.new(patient_params)
		if @patient.save
		#	@patient.send_activation_email
		#	flash[:notice] = "Please check your email to activate your account"
			redirect_to root_url 
		else
			render :new
		end
	end

	def show
		@patient = Patient.where(patient: true).find(params[:id])
	end

	def edit
		@patient = Patient.where(patient: true).find(params[:id])
	end

	def update
		@patient = Patient.where(patient: true).find(params[:id])
		if @patient.update_attributes(patient_params)
			flash[:success] = "Profile updated"
			redirect_to @patient
		else
			flash.now[:error] = "Unable to update profile"
			render :edit
		end
	end

	def destroy
		Patient.where(patient: true).find(params[:id]).destroy
		flash[:success] = "Patient deleted"
		redirect_to patients_url
	end


	private
		def patient_params
			params.require(:patient).permit(:title, :first_name, :middle_name, :last_name, :dob, :gender, :nhs_number, :phone, :username, :address, :email, :password, :password_confirmation, :admin, :doctor, :patient, :receptionist)
		end

end
