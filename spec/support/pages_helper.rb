module PagesHelper
	def privileged_user_is_logged_in
		@privileged_user_is_logged_in = @current_user && (@current_user.admin? || @current_user.doctor? || @current_user.receptionist?)
	end

	def doctor_or_receptionist_is_logged_in
		@doctor_or_receptionist_is_logged_in = @current_user && (@current_user.doctor? || @current_user.receptionist?)
	end

	def senior_staff_member_is_logged_in
		@senior_staff_member_is_logged_in = @current_user && (@current_user.admin? || @current_user.doctor?)
	end

	def admin_is_logged_in
		@admin_is_logged_in = @current_user && @current_user.admin?
	end
	
	def who_is_the_current_user
#		if @current_user.present? && (@current_user.id == user_dot_id)
#			return true
#		else
#			return false
#		end
		def is_the_current_user(user_dot_id)
			who = Proc.new {|user_dot_id| @current_user.present? && (@current_user.id == user_dot_id) }
			who.call(user_dot_id)
		end
	end

end
