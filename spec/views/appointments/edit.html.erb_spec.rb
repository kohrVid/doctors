require 'rails_helper'

RSpec.describe "appointments/edit.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
		assign(:appointment, appointment)
	end

	context "attributes" do
		before(:each) do
			assign(:current_user, user)
			render :template => "appointments/edit", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Edit Appointment")
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
			assign(:current_user, Patient.find(appointment.patient_id))
			render :template => "appointments/edit", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsDr Eric Hammer - 03/12/2015 11:05Edit Appointment")
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: patient_appointments_path(appointment.patient_id))
		end
		
		it "should have a link to the appointment's show page" do
			expect(rendered).to have_link("Appointment Details", href: patient_appointment_path(appointment.patient_id, appointment.id))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "appointments/edit", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05Edit Appointment")
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
		it "should have a link to the appointment's show page" do
			expect(rendered).to have_link("Appointment Details", href: appointment_path(appointment))
		end
	end
	
	context "Doctor" do
		before(:each) do
			assign(:current_user, Doctor.find(appointment.doctor_id))
			render :template => "appointments/edit", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05Edit Appointment")
		end

		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: doctor_appointments_path(appointment.doctor_id))
		end
		
		it "should have a link to the appointment's show page" do
			expect(rendered).to have_link("Appointment Details", href: doctor_appointment_path(appointment.doctor_id, appointment.id))
		end
	end

	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "appointments/edit", :layout => "layouts/application"
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeAppointmentsJason Slater - 03/12/2015 11:05Edit Appointment")
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
		it "should have a link to the appointment's show page" do
			expect(rendered).to have_link("Appointment Details", href: appointment_path(appointment))
		end
	end
end
