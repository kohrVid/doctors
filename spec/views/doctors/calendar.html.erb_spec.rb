require 'rails_helper'

RSpec.describe "doctors/calendar.html.erb", type: :view do
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:appointment) { FactoryGirl.create(:appointment) }
	before(:each) do
			assign(:doctor, doctor)
			assign(:appointments, Appointment.all)
	end
=begin
	context "Non-Users" do
		before(:each) do
			render :template => "/doctors/calendar", :layout => "layouts/application", :id => doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Doctor's Calendar")
		end

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should display the correct title" do
			expect(rendered).to have_content("Dr Eric Hammer's Calendar")
		end
	end

	context "Patient" do
		before(:each) do
			assign(:doctor, doctor)
			assign(:current_user, FactoryGirl.create(:patient))
			render :template => "/doctors/calendar", :layout => "layouts/application", :id => doctor.id
		end
		
		it "should not display the full title of page" do
			expect(rendered).to_not have_title("The Doctor's | Doctor's Calendar")
		end

		it "should not display the correct breadcrumb" do
			expect(rendered).to_not have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should not display the correct title" do
			expect(rendered).to_not have_content("Dr Eric Hammer's Calendar")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "/doctors/calendar", :layout => "layouts/application", :id => doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Doctor's Calendar")
		end

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should display the correct title" do
			expect(rendered).to have_content("Dr Eric Hammer's Calendar")
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:current_user, doctor)
			render :template => "doctors/calendar", :layout => "layouts/application", id: doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Doctor's Calendar")
		end

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should display the correct title" do
			expect(rendered).to have_content("Dr Eric Hammer's Calendar")
		end
	end

	context "Other Doctors" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor, username: "drmrsthemonarch", email: "drmrsthemonarch@thehospital.com"))
			render :template => "/doctors/calendar", :layout => "layouts/application", :id => doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Doctor's Calendar")
		end

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should display the correct title" do
			expect(rendered).to have_content("Dr Eric Hammer's Calendar")
		end
	end
=end
	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "/doctors/calendar", :layout => "layouts/application", :id => doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Doctor's Calendar")
		end

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeDoctorsDr Eric Hammer's Calendar")
		end
		
		it "should display the correct title" do
			expect(rendered).to have_content("Dr Eric Hammer's Calendar")
		end
	end
end
