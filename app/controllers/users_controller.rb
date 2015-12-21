class UsersController < ApplicationController
	load_and_authorize_resource
	before_action	:who_is_the_current_user, 
			:admin_is_logged_in, 
			:senior_staff_member_is_logged_in, 
			:doctor_or_receptionist_is_logged_in, 
			:privileged_user_is_logged_in

	def index
		@users = User.all.order(:id)
	end

	def new
		@user = User.new
		@user.build_address
	end

	def create
		@user = User.new(user_params)
		if @user.save
		#	@user.send_activation_email
		#	flash[:notice] = "Please check your email to activate your account"
			redirect_to root_url 
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			flash.now[:error] = "Unable to update profile"
			render :edit
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	def bulk_user_approval
	end
	
	def bulk_user_approved
		params["user"].keys.each do |id|
			@user = User.find(id.to_i)
			@user.update_attributes(bulk_approval_params(id)) 
		end
		redirect_to(bulk_user_approval_url)
	end


	private
		def user_params
			params.require(:user).permit(:title, :first_name, 
						     :middle_name, :last_name, 
						     :dob, :phone, :username, 
						     :address, :email, :password, 
						     :password_confirmation, :admin, 
						     :doctor, :patient, :receptionist, 
						     :approved, :locked)
		end

		def bulk_approval_params(id)
			params.require(:user).fetch(id).permit(:approved, :locked, 
							       :title, :first_name, 
							       :middle_name, :last_name, 
							       :dob, :phone, :username, 
							       :address, :email, :password, 
							       :password_confirmation, :admin, 
							       :doctor, :patient, :receptionist)
		end
end
