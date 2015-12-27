require 'rails_helper'

RSpec.describe "appointments/show.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	context "attributes" do
		before(:each) do
			assign(:appointment, appointment)
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
			@current_user = User.find(appointment.patient_id)
			@patient_is_logged_in = true
			@doctor_is_logged_in = false
			@senior_staff_member_is_logged_in = false
			assign(:appointment, appointment)
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
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
			@current_user = FactoryGirl.create(:receptionist)
			@patient_is_logged_in = false
			@doctor_is_logged_in = false
			@senior_staff_member_is_logged_in = false
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
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
			@current_user = User.find(appointment.doctor_id)
			@patient_is_logged_in = false
			@doctor_is_logged_in = true
			@senior_staff_member_is_logged_in = true
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
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
			@current_user = FactoryGirl.create(:admin)
			@patient_is_logged_in = false
			@doctor_is_logged_in = false
			@senior_staff_member_is_logged_in = true
			@admin_is_logged_in = true
			render :template => "appointments/show", :layout => "layouts/application", :id => appointment.id
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
