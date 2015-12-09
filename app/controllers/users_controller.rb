class UsersController < ApplicationController
	load_and_authorize_resource
	def index
		@users = User.all
	end

	def new
		@user = User.new
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


	private
		def user_params
			params.require(:user).permit(:title, :first_name, :middle_name, :last_name, :dob, :phone, :username, :address, :email, :password, :password_confirmation, :admin, :doctor, :patient, :receptionist)
		end
end
