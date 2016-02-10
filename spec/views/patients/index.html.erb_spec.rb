require 'rails_helper'

RSpec.describe "patients/index.html.erb", type: :view do
	let(:user) { FactoryGirl.create(:user) }
	let(:patient) { FactoryGirl.create(:patient) }
	
	context "Receptionist" do
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient: true))
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "patients/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: patient_path(patient))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "has an Add New Patient button" do
			expect(rendered).to have_link("Add New Patient", href: new_patient_path)
		end
	end
	
	context "Doctor" do
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient: true))
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "patients/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: patient_path(patient))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "has an Add New Patient button" do
			expect(rendered).to have_link("Add New Patient", href: new_patient_path)
		end
	end
	
	context "Admin" do	
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient: true))
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "patients/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Patients")
		end
		
		it "has a Name" do
			expect(rendered).to have_content(patient.full_name)
		end

		it "has a Username" do
			expect(rendered).to have_content(patient.username)
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: patient_path(patient))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end

		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "has an Add New Patient button" do
			expect(rendered).to have_link("Add New Patient", href: new_patient_path)
		end
	end
end
