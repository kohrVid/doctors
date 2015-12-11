require 'rails_helper'

RSpec.describe "patients/index.html.erb", type: :view do
	let(:user) { FactoryGirl.create(:user) }
	let(:patient) { FactoryGirl.create(:patient) }
	context "Admin" do	
		before(:each) do
			assign(:patient, patient)
			@patients = Patient.all.where(patient: true)
			@current_user = FactoryGirl.create(:admin)
			render :template => "patients/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Patients")
		end
		
		it "has a Name" do
			expect(rendered).to have_content("Name")
		end

		it "has a Username" do
			expect(rendered).to have_content("Username")
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
	end

	context "Doctor" do
		before(:each) do
			assign(:patient, patient)
			@patients = Patient.all.where(patient: true)
			@current_user = FactoryGirl.create(:doctor)
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
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:patient, patient)
			@patients = Patient.all.where(patient: true)
			@current_user = FactoryGirl.create(:receptionist)
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
	end
	
	context "Patient" do	
		before(:each) do
			assign(:patient, patient)
			@patients = Patient.all
			@current_user = patient
			render :template => "patients/index", :layout => "layouts/application"
		end
		
		it "must not see Name" do
			expect(rendered).to_not have_content("Name")
		end

		it "must not see Username" do
			expect(rendered).to_not have_content("Username")
		end
		
		it "must not have a show button" do
			expect(rendered).to_not have_link("Show", href: patient_path(patient))
		end

		it "must not have an edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_patient_path(patient))
		end

		it "must not have a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end
end
