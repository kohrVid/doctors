require 'rails_helper'

RSpec.describe "pages/index.html.erb", type: :view do
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	context "Non-Users" do
		before(:each) do
			assign(:testimonial, testimonial)
			@contact = Contact.new
			render :template => "pages/index", :layout => "layouts/application"
		end
		it "must display testimonials" do
			expect(rendered).to have_content(testimonial.body)
		end
	end

	context "Patients" do
		before(:each) do
			assign(:testimonial, testimonial)
			@contact = Contact.new
			@current_user = FactoryGirl.create(:patient)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "should not show a list of patients awaiting approval" do
			expect(rendered).to_not have_selector("select[name='Patients[unapproved]']")
		end

		it "should not show link to bulk_approval page" do
			expect(rendered).to_not have_link("Bulk Approval", bulk_patient_approval_path)
		end
	end

	context "Receptionists" do
		before(:each) do
			assign(:testimonial, testimonial)
			@contact = Contact.new
			@current_user = FactoryGirl.create(:receptionist)
			@privileged_user_is_logged_in = true
			@doctor_or_receptionist_is_logged_in = true
			render :template => "pages/index", :layout => "layouts/application"
		end
	
		it "should show a list of patients awaiting approval" do
			expect(rendered).to have_selector("select[name='Patients[unapproved]']")
		end

		it "should show link to bulk_approval page" do
			expect(rendered).to have_link("Bulk Approval", bulk_patient_approval_path)
		end
	end

	context "Doctors" do
		before(:each) do
			assign(:testimonial, testimonial)
			@contact = Contact.new
			@current_user = FactoryGirl.create(:doctor)
			@privileged_user_is_logged_in = true
			@doctor_or_receptionist_is_logged_in = true
			@senior_staff_member_is_logged_in = true
			render :template => "pages/index", :layout => "layouts/application"
		end

		it "has an Add Testimonial button" do
			expect(rendered).to have_link("Add Testimonial", href: new_testimonial_path)
		end
		
		it "has a Manage Testimonials button" do
			expect(rendered).to have_link("Manage Testimonials", href: testimonials_path)
		end
		
		it "should show a list of patients awaiting approval" do
			expect(rendered).to have_selector("select[name='Patients[unapproved]']")
		end

		it "should show link to bulk_approval page" do
			expect(rendered).to have_link("Bulk Approval", bulk_patient_approval_path)
		end
	end

	context "Admin" do
		before(:each) do
			assign(:testimonial, testimonial)
			@contact = Contact.new
			@current_user = FactoryGirl.create(:admin)
			@privileged_user_is_logged_in = true
			@senior_staff_member_is_logged_in = true
			@admin_is_logged_in = true
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "has an Add Testimonial button" do
			expect(rendered).to have_link("Add Testimonial", href: new_testimonial_path)
		end
		
		it "has a Manage Testimonials button" do
			expect(rendered).to have_link("Manage Testimonials", href: testimonials_path)
		end
		
		it "should show a list of users awaiting approval" do
			expect(rendered).to have_selector("select[name='Users[unapproved]']")
		end

		it "should show link to bulk_approval page" do
			expect(rendered).to have_link("Bulk Approval", bulk_user_approval_path)
		end
	end
end
