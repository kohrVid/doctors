class UserSessionsController < ApplicationController
	def new
		@user_session = UserSession.new
	end

	def create
		@user_session = UserSession.new(user_session_params)
		if @user_session.save
			redirect_to root_path
		else
			flash.now[:error] = "Failed login"
			render :new
		end
	end

	def destroy
		current_user_session.destroy
		flash.now[:success] = "You have successfully logged out."
		redirect_to root_path
	end


	private
		def user_session_params
			params.require(:user_session).permit(:username, :password)
		end
end
