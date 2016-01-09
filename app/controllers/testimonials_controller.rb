class TestimonialsController < ApplicationController
	load_and_authorize_resource

	def index
		@testimonials = Testimonial.all
	end

	def new
		@testimonial = Testimonial.new
	end

	def create
		@testimonial = Testimonial.new(testimonial_params)
		if @testimonial.save
			flash[:success] = "Testimonial created"
			redirect_to root_url 
		else
			flash.now[:error] = "Unable to create testimonial"
			render :new
		end
	end

	def show
		@testimonial = Testimonial.find(params[:id])
	end

	def edit
		@testimonial = Testimonial.find(params[:id])
	end

	def update
		@testimonial = Testimonial.find(params[:id])
		if @testimonial.update_attributes(testimonial_params)
			flash[:success] = "Testimonial updated"
			redirect_to @testimonial
		else
			flash.now[:error] = "Unable to update testimonial"
			render :edit
		end
	end

	def destroy
		Testimonial.find(params[:id]).destroy
		flash[:success] = "Testimonial deleted"
		redirect_to testimonials_url
	end


	private
		def testimonial_params
			params.require(:testimonial).permit(:author, :date, :body)
		end
	
end
