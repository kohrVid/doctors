class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	ensure_security_headers
	include CanCan::ControllerAdditions
	include PagesHelper
	helper_method :current_user_session, :current_user
	# self.responder = ApplicationResponder
	
	
	private
	
		def current_user_session
			@current_user_session ||= UserSession.find
		end

		def current_user
			@current_user ||= current_user_session && current_user_session.user
		end

end
