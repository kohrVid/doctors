require 'rails_helper'

RSpec.describe "testimonials/edit.html.erb", type: :view do
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	before(:each) do
		assign(:testimonial, testimonial)
		@current_user = FactoryGirl.create(:admin)
		render :template => "testimonials/edit", :layout => "layouts/application"
	end
	
	it "must display the full title of page" do
		expect(response).to have_title("The Doctor's | Edit Testimonial")
	end
	
	it "has a form posting to /testimonials" do
		expect(response).to have_selector("form")
	end

	it "has an input for Body" do
		expect(response).to have_selector("textarea[name*=body]")
	end

	it "has an input for Author" do
		expect(rendered).to have_selector("input[name*=author]")
	end
	
	it "has an input for Date" do
		expect(rendered).to have_selector("select[name*=date]")
	end

	it "should display a Submit button" do
		expect(rendered).to have_selector("input[name*=commit]")
	end
	
	it "should have a Destroy button" do
		expect(rendered).to have_link("Destroy")
	end
	
	it "should have a Back to Testimonials button" do
		expect(rendered).to have_link("<< Back to Testimonials", href: testimonials_path)
	end
	
	it "should have a link to the Testimonial's show page" do
		expect(rendered).to have_link("Show Testimonial", href: testimonial_path(testimonial))
	end
end
