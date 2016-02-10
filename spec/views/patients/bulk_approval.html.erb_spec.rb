require 'rails_helper'

RSpec.describe "patients/bulk_approval.html.erb", type: :view do
	let(:patient) { FactoryGirl.create(:patient, approved: false) }
	
	context "Patient" do	
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient:true, approved: false))
			assign(:current_user, FactoryGirl.create(:user))
			render :template => "patients/bulk_approval", :layout => "layouts/application"
		end
		
		it "must not see Name" do
			expect(rendered).to_not have_content(patient.full_name)
		end

		it "must not see Username" do
			expect(rendered).to_not have_link(patient.full_name, href: patient_path(patient))
		end
		
		it "must not have an Approval boolean" do
			expect(rendered).to_not have_selector("input[name*=approved]")
		end

		it "must not have a Locked boolean" do
			expect(rendered).to_not have_selector("input[name*=locked]")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient:true, approved: false))
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "patients/bulk_approval", :layout => "layouts/application"
		end
		
		it "must see Name" do
			expect(rendered).to have_content(patient.full_name)
		end

		it "must see Username" do
			expect(rendered).to have_link(patient.full_name, href: patient_path(patient))
		end
		
		it "must have an Approval boolean" do
			expect(rendered).to have_selector("input[name*=approved]")
		end

		it "must have a Locked boolean" do
			expect(rendered).to have_selector("input[name*=locked]")
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient:true, approved: false))
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "patients/bulk_approval", :layout => "layouts/application"
		end
		
		it "must see Name" do
			expect(rendered).to have_content(patient.full_name)
		end

		it "must see Username" do
			expect(rendered).to have_link(patient.full_name, href: patient_path(patient))
		end
		
		it "must have an Approval boolean" do
			expect(rendered).to have_selector("input[name*=approved]")
		end

		it "must have a Locked boolean" do
			expect(rendered).to have_selector("input[name*=locked]")
		end
	end

	context "Admin" do	
		before(:each) do
			assign(:patient, patient)
			assign(:patients, Patient.where(patient:true, approved: false))
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "patients/bulk_approval", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Bulk Patient Approval")
		end
		
		it "must see Name" do
			expect(rendered).to have_content(patient.full_name)
		end

		it "must see Username" do
			expect(rendered).to have_link(patient.full_name, href: patient_path(patient))
		end
		
		it "must have an Approval boolean" do
			expect(rendered).to have_selector("input[name*=approved]")
		end

		it "must have a Locked boolean" do
			expect(rendered).to have_selector("input[name*=locked]")
		end
	end
end
