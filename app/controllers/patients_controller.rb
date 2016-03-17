class PatientsController < ApplicationController
	load_and_authorize_resource
	skip_authorize_resource :only => [:bulk_patient_approval, :bulk_patient_approved]
	respond_to :html

	def index
		@patients = Patient.where(patient: true).order(:id)
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
			flash.now[:danger] = "Unable to create patient"
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
		flash.now[:success] = "Patient deleted"
		render :index
	end

	def bulk_patient_approval
	end
	
	def bulk_patient_approved
		params["patient"].keys.each do |id|
			@patient = Patient.find(id.to_i)
			@patient.update_attributes(bulk_approval_params(id)) 
		end
		redirect_to(bulk_patient_approval_url)
	end

	def calendar
		@patient = Patient.where(patient: true).find(params[:id])
		@appointments = Appointment.where(patient_id: @patient.id)
		respond_with do |format|
			format.html { render 'calendar' }
		end
	end


	private
		def patient_params
			params.require(:patient).permit(:title, :first_name, 
							:middle_name, :last_name, 
							:dob, :gender, :nhs_number, 
							:phone, :username, :email,
							:password, :password_confirmation, 
							:admin, :doctor, :patient, 
							:receptionist, :approved, :locked,
							address_attributes: [:street,
			    				:address_line2, :city,
							:county, :post_code])
		end
		
		def bulk_approval_params(id)
			params.require(:patient).fetch(id).permit(:approved, :locked, 
								  :title, :first_name, 
								  :middle_name, :last_name, 
								  :dob, :gender, :nhs_number, 
								  :phone, :username, :address, 
								  :email, :password, 
								  :password_confirmation, 
								  :admin, :doctor, :patient, 
								  :receptionist)
		end
end
