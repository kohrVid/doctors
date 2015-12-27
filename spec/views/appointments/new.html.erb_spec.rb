require 'rails_helper'

RSpec.describe "appointments/new.html.erb", type: :view do
	let(:appointment) { FactoryGirl.create(:appointment) }
	context "attributes" do
		before(:each) do
			assign(:appointment, appointment)
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | New Appointment")
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
			@current_user = User.find(appointment.patient_id)
			@patient_is_logged_in = true
			@doctor_is_logged_in = false
			@senior_staff_member_is_logged_in = false
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
			@current_user = FactoryGirl.create(:receptionist)
			@patient_is_logged_in = false
			@doctor_is_logged_in = false
			@senior_staff_member_is_logged_in = false
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
		
	end
	
	context "Doctor" do
		before(:each) do
			assign(:appointment, appointment)
			@current_user = User.find(appointment.doctor_id)
			@patient_is_logged_in = false
			@doctor_is_logged_in = true
			@senior_staff_member_is_logged_in = true
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: doctor_appointments_path(appointment.doctor_id))
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
			render :template => "appointments/new", :layout => "layouts/application"
		end
		
		it "should have a Back to Appointments button" do
			expect(rendered).to have_link("<< Back to Appointments", href: appointments_path)
		end
	end

end
