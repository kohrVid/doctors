require 'rails_helper'

RSpec.describe "appointments/show.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	let(:user) { FactoryGirl.create(:user) }
	context "attributes" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, user)
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Appointment Details")
		end

		it "shows the Patient's name" do
			expect(rendered).to have_content(Patient.find(appointment.patient_id).full_name)
		end

		it "shows the Doctor's name" do
			expect(response).to have_content(Doctor.find(appointment.doctor_id).dr_full_name)
		end
		
		it "shows Date" do
			expect(rendered).to have_content(appointment.start_time.strftime("%d %B %Y"))
		end

		it "shows Start Time" do
			expect(rendered).to have_content(appointment.start_time.strftime("%H:%M:%S"))
		end

		it "shows End Time" do
			expect(rendered).to have_content(appointment.end_time.strftime("%H:%M:%S"))
		end

		it "shows Description" do
			expect(rendered).to have_content("Description: "+ appointment.description.to_s)
		end

		it "should have a Cancellation status" do
			expect(rendered).to have_content("Status: Active")
		end
	end
		
	context "Patient" do
		before(:each) do
			assign(:current_user, User.find(appointment.patient_id))
			assign(:appointment, appointment)
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsDr Eric Hammer - 03/12/2015 11:05")
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: patient_appointments_path(appointment.patient_id))
		end
		
		it "should have an Edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_appointment_path(appointment.patient_id, appointment.id))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05")
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
		it "should have an Edit button" do
			expect(rendered).to have_link("Edit", href: edit_appointment_path(appointment.id))
		end
	end
	
	context "Doctor" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, User.find(appointment.doctor_id))
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05")
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: doctor_appointments_path(appointment.doctor_id))
		end
		
		it "should have an Edit button" do
			expect(rendered).to have_link("Edit", href: edit_doctor_appointment_path(appointment.doctor_id, appointment.id))
		end
	end

	context "Admin" do
		before(:each) do
			assign(:appointment, appointment)
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05")
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
		it "should have an Edit button" do
			expect(rendered).to have_link("Edit", href: edit_appointment_path(appointment.id))
		end
	end
end
