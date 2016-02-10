require 'rails_helper'

RSpec.describe "layouts/header.html.erb", type: :view do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:admin) { FactoryGirl.create(:admin) }

	context "Non-User" do
		before(:each) do
			assign(:contact, Contact.new)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "shows app name" do
			expect(rendered).to have_content("The Doctor's")
		end

		it "shows a Registration button" do
			expect(rendered).to have_link("Register", href: register_path)
		end
		
		it "shows a link to Home" do
			expect(rendered).to have_link(href: root_path, count: 2)
		end
		
		it "shows a Log In button" do
			expect(rendered).to have_link("Log In", href: login_path)
		end

		it "has a Book an Appointment button" do
			expect(rendered).to have_link("Book an appointment", href: new_appointment_path)
		end

	end

	context "Patient" do
		before(:each) do
			assign(:contact, Contact.new)
			assign(:current_user, patient)
			render :template => "pages/index", :layout => "layouts/application"
		end

		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: patient_path(patient))
		end

		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:contact, Contact.new)
			assign(:current_user, receptionist)
			render :template => "pages/index", :layout => "layouts/application"
		end
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: user_path(receptionist))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:contact, Contact.new)
			assign(:current_user, doctor)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: doctor_path(doctor))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
	
	context "Admin" do
		before(:each) do
			assign(:contact, Contact.new)
			assign(:current_user, admin)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: user_path(admin))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
end
