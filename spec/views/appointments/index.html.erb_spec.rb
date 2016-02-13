require 'rails_helper'

RSpec.describe "appointments/index.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
		assign(:appointment, appointment)
		assign(:appointments, Appointment.all)
	end

	context "attributes" do
		before(:each) do
			assign(:current_user, user)
			render :template => "appointments/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Appointments")
		end
		
	end
		
	context "Patient" do
		before(:each) do
			assign(:current_user, Patient.find(appointment.patient_id))
			render :template => "appointments/index", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointments")
		end
	
		it "must appear if not cancelled"
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "appointments/index", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointments")
		end
	
		it "must appear if not cancelled"
	end
	
	context "Doctor" do
		before(:each) do
			assign(:current_user, Doctor.find(appointment.doctor_id))
			render :template => "appointments/index", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointments")
		end
	
		it "must appear if not cancelled"
	end

	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "appointments/index", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointments")
		end
		
		it "must appear if not cancelled"
	end
end
