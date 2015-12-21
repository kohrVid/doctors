require 'rails_helper'

RSpec.describe "testimonials/show.html.erb", type: :view do
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	before(:each) do
		@current_user = FactoryGirl.create(:admin)
		assign(:testimonial, testimonial)
		render :template => "testimonials/show", :layout => "layouts/application", :id => testimonial.id
	end
	
	it "must display the full title of page" do
		expect(rendered).to have_title("The Doctor's | Show Testimonial")
	end
	
	it "should show Body" do
		expect(rendered).to have_content(testimonial.body)
	end

	it "should show Author" do
		expect(rendered).to have_content(testimonial.author)
	end
	
	it "should show Date" do
		expect(rendered).to have_content(testimonial.date.strftime("%d %B %Y"))
	end

	it "should show Date Created" do
		expect(rendered).to have_content(testimonial.created_at.strftime("%d %B %Y %H:%M:%S"))
	end

	it "should show Date Last Modified" do
		expect(rendered).to have_content(testimonial.updated_at.strftime("%d %B %Y %H:%M:%S"))
	end


	it "should show edit button" do
		expect(rendered).to have_link("Edit", href: edit_testimonial_path(testimonial))
	end
	
	it "should have a back to testimonials button" do
		expect(rendered).to have_link("<< Back to Testimonials", href: testimonials_path)
	end
end
