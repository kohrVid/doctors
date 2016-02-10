class AppointmentsController < ApplicationController
	before_action :logged_in_user, only: [:index, :new]
	load_and_authorize_resource

	def index
		@appointments = Appointment.all
	#	format.js
	end

	def new
		@appointment = Appointment.new
	end

	def create
		@appointment = Appointment.new(appointment_params)
		if @appointment.save
			flash.now[:notice] = "Appointment has been successfully created"
			render :index
		else
			flash.now[:error] = "Unable to create appointment"
			render :new
		end
	end

	def show
		@appointment = Appointment.find(params[:id])
	end

	def edit
		@appointment =  Appointment.find(params[:id])
		@appointments = Appointment.all
	end

	def update
		@appointment = Appointment.find(params[:id])
		if @appointment.update_attributes(appointment_params)
			flash.now[:success] = "Appointment has been successfully updated"
			redirect_to @appointment
		else
			flash.now[:error] = "Unable to update appointment"
			render :edit
		end
	end

	def destroy
		@appointment = Appointment.find(params[:id])
		@appointment.destroy
		flash.now[:success] = "Appointment deleted"
		redirect_to appointments_url
	end


	private
		def appointment_params
			params.require(:appointment).permit(:doctor_id, :patient_id, :start_time, :end_time, :description, :cancelled)
		end

		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
end
