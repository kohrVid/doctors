require 'rails_helper'

RSpec.describe "layouts/header.html.erb", type: :view do
	context "Non-User" do
		before(:each) do
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

	end

	context "Patient" do
		before(:each) do
			@current_user = FactoryGirl.create(:patient)
			render :template => "pages/index", :layout => "layouts/application"
		end

		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: patient_path(@current_user))
		end

		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "pages/index", :layout => "layouts/application"
		end
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: user_path(@current_user))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end

	context "Doctor" do
		before(:each) do
			@current_user = FactoryGirl.create(:doctor)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: doctor_path(@current_user))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
	
	context "Admin" do
		before(:each) do
			@current_user = FactoryGirl.create(:admin)
			render :template => "pages/index", :layout => "layouts/application"
		end
		
		it "should show a Account Settings button" do
			expect(rendered).to have_link("Account Settings", href: user_path(@current_user))
		end
		
		it "should show a Log Out button" do
			expect(rendered).to have_link("Log Out")
		end
	end
end
