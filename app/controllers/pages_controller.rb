class PagesController < ApplicationController
	before_action :admin_is_logged_in, :senior_staff_member_is_logged_in

	def index
		@contact = Contact.new
		@pages = Page.all
	end

	def new
		@page = Page.new
		authorize! :new, @page
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
		authorize! :create, @page
	end

	def show
		@page = Page.friendly.find(params[:id])
		authorize! :show, @page
	end

	def edit
		@page = Page.friendly.find(params[:id])
	end

	def update
		@page = Page.friendly.find(params[:id])
		if @page.update_attributes(page_params)
			flash[:success] = "Page updated"
			redirect_to @page
		else
			flash.now[:error] = "Unable to update page"
			render :edit
		end
		authorize! :update, @page
	end

	def destroy
		Page.friendly.find(params[:id]).destroy
		flash[:success] = "Page deleted"
		redirect_to pages_url
		authorize! :destroy, @page
	end


	private
		def page_params
			params.require(:page).permit(:title, :description)
		end
end
