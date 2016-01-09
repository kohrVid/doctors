class PagesController < ApplicationController
	load_and_authorize_resource

	def index
#		@pages = PagesIndex.new
#		@page.index
		@contact = Contact.new
=begin
		@pages = Page.all
		@contact = Contact.new
		@users = User.all
=end
	end

	def new
		@page = Page.new
	end

	def create
		@page = Page.new(page_params)
		if @page.save
		#	@page.send_activation_email
		#	flash[:notice] = "Please check your email to activate your account"
			redirect_to root_url 
		else
			render :new
		end
	end

	def show
		@page = Page.find(params[:id])
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(page_params)
			flash[:success] = "Page updated"
			redirect_to @page
		else
			flash.now[:error] = "Unable to update page"
			render :edit
		end
	end

	def destroy
		Page.find(params[:id]).destroy
		flash[:success] = "Page deleted"
		redirect_to pages_url
	end


	private
		def page_params
			params.require(:page).permit(:title, :description)
		end
end
