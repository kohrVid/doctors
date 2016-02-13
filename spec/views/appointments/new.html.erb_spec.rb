require 'rails_helper'

RSpec.describe "appointments/new.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	let(:user) { FactoryGirl.create(:user) }

	context "attributes" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, user)
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | New Appointment")
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsNew Appointment")
		end
		
		it "has a form posting to /appointments" do
			expect(response).to have_selector("form")
		end

		it "has an dropdown for Doctor's name" do
			expect(response).to have_selector("select[name*=doctor_id]")
		end

		it "has an dropdown for Patient's name" do
			expect(rendered).to have_selector("select[name*=patient_id]")
		end
		
		it "has an input for Start Time" do
			expect(rendered).to have_selector("select[name*=start_time]")
		end
		it "has an input for End Time" do
			expect(rendered).to have_selector("select[name*=end_time]")
		end

		it "has an input for Description" do
			expect(rendered).to have_selector("textarea[name*=description]")
		end

		it "should have a Cancelled boolean" do
			expect(rendered).to have_selector("input[name*=cancelled]")
		end
		
		it "should display a submit button" do
			expect(rendered).to have_selector("input[name*=commit]")
		end
		
	end
		
	context "Patient" do
		before(:each) do
			assign(:current_user, User.find(appointment.patient_id))
			assign(:appointment, appointment)
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: patient_appointments_path(appointment.patient_id))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
	end
	
	context "Doctor" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, User.find(appointment.doctor_id))
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: doctor_appointments_path(appointment.doctor_id))
		end
	end

	context "Admin" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
	end

end
