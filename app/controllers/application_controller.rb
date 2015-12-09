class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  ensure_security_headers
  

#  self.responder = ApplicationResponder
  helper_method :current_user_session, :current_user

  private
  	def current_user_session
		@current_user_session ||= UserSession.find
	end

	def current_user
		@current_user ||= current_user_session && current_user_session.user
	end


	def layout_with_mercury
		!params[:mercury_frame] && is_editing? ? 'mercury' : 'application'
	end

	def is_editing?
		cookies[:editing] == 'true' && can_edit?
	end
end
