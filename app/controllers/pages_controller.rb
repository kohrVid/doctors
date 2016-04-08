class PagesController < ApplicationController
#	before_action :admin_is_logged_in, :senior_staff_member_is_logged_in

	def index
		@contact = Contact.new
		@pages = Page.all
		authorize! :index, Page
	end

	def new
		@page = Page.new
		authorize! :new, @page
	end

	def create
		@page = Page.new(page_params)
		if @page.save
			flash[:notice] = "The page has been successfully created."
			redirect_to root_url 
		else
			flach[:error] = "An error has preveneted this page from being created."
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
		authorize! :edit, @page
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
