require 'rails_helper'

RSpec.describe "pages/index.html.erb", type: :view do
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	context "Non-Users" do
		before(:each) do
			assign(:testimonial, testimonial)
			render :template => "pages/index", :layout => "layouts/application"
		end
		it "must display testimonials" do
			expect(rendered).to have_content(testimonial.body)
		end
	end

	context "Patients" do
		before(:each) do
			assign(:testimonial, testimonial)
			@current_user = FactoryGirl.create(:patient)
			render :template => "pages/index", :layout => "layouts/application"
		end

	end

	context "Receptionists" do
		before(:each) do
			assign(:testimonial, testimonial)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "pages/index", :layout => "layouts/application"
		end
	end

	context "Doctors" do
		before(:each) do
			assign(:testimonial, testimonial)
			@current_user = FactoryGirl.create(:doctor)
			render :template => "pages/index", :layout => "layouts/application"
		end

		it "has an Add Testimonial button" do
			expect(rendered).to have_link("Add Testimonial", href: new_testimonial_path)
		end
		
		it "has a Manage Testimonials button" do
			expect(rendered).to have_link("Manage Testimonials", href: testimonials_path)
		end
		
		it "must present an alert to doctors/admins when there are users awaiting approval"
	end

	context "Admin" do
		before(:each) do
			assign(:testimonial, testimonial)
			@current_user = FactoryGirl.create(:admin)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "has an Add Testimonial button" do
			expect(rendered).to have_link("Add Testimonial", href: new_testimonial_path)
		end
		
		it "has a Manage Testimonials button" do
			expect(rendered).to have_link("Manage Testimonials", href: testimonials_path)
		end
	end
	it "must present an alert to doctors/admins when there are users awaiting approval"
end
