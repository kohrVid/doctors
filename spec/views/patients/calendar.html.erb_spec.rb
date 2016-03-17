require 'rails_helper'

RSpec.describe "patients/calendar.html.erb", type: :view do
	let(:patient) { FactoryGirl.create(:patient, approved: false) }
	let(:admin) { FactoryGirl.create(:admin) }

	context "Title" do
		before(:each) do
			assign(:patient, patient)
			assign(:appointments, Appointment.all)
			assign(:current_user, admin)
			render :template => "/patients/calendar", :layout => "layouts/application", :id => patient.id
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Patient Calendar")
		end
		

		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomePatientsJason Slater's Calendar")
		end
	end
end
