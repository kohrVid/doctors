class ContactsController < ApplicationController
	
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.deliver if @contact.valid?
		@contact.request = request
		@object = @contact

		if @contact.deliver
			flash.now[:notice] = 'Thank you for your message! I try to respond within 24hrs so you should hear from me soon.'
			render :thanks
		else
			flash.now[:error] = 'Unable to send message.'
			render :new
		end
	end

	def thanks
	end

	private
		def contact_params
			params.require(:contact).permit(:name, :email, 
							:message, :nickname)
		end

end
