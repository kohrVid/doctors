require 'rails_helper'

RSpec.describe "testimonials/new.html.erb", type: :view do
	before(:each) do
		assign(:testimonial, Testimonial.new)
		assign(:current_user, FactoryGirl.create(:admin))
		render :template => "testimonials/new", :layout => "layouts/application"
	end
	
	it "must display the full title of page" do
		expect(rendered).to have_title("The Doctor's | New Testimonial")
	end
	
	it "must display the correct breadcrumb" do
		expect(rendered).to have_content("You are here: HomeTestimonialsNew Testimonial")
	end
	
	it "has a form posting to /testimonials" do
		expect(rendered).to have_selector("form")
	end

	it "has an textarea for Body" do
		expect(rendered).to have_selector("textarea[name*=body]")
	end

	it "has an input for Author" do
		expect(rendered).to have_selector("input[name*=author]")
	end
	
	it "has an input for Date" do
		expect(rendered).to have_selector("select[name*=date]")
	end

	it "should display a submit button" do
		expect(rendered).to have_selector("input[name*=commit]")
	end
	
	it "should have a back to testimonials button" do
		expect(rendered).to have_link("<< Back to Testimonials", href: testimonials_path)
	end
end
