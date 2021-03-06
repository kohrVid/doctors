require 'rails_helper'

RSpec.describe "patients/show.html.erb", type: :view do
	let(:patient) { FactoryGirl.create(:patient) }
	
	before(:each) do
		assign(:patient, patient)
	end

	context "attributes" do
		before(:each) do
		      render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Jason Slater")
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomePatientsJason Slater")
		end
		
		it "shows Title" do
			expect(rendered).to have_content(patient.title)
		end

		it "shows First Name" do
			expect(rendered).to have_content(patient.first_name)
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content(patient.middle_name)
		end

		it "shows Last Name" do
			expect(rendered).to have_content(patient.last_name)
		end

		it "shows Date of Birth" do
			expect(rendered).to have_content(patient.dob.strftime("%d %B %Y"))
		end

		it "shows Age" do
			expect(rendered).to have_content(DateTime.now.year - patient.dob.year)
		end

		it "shows Username" do
			expect(rendered).to have_content(patient.username)
		end
		
		it "shows Email Address" do
			expect(rendered).to have_content(patient.email)
		end
		
		it "shows input for Street" do
			expect(rendered).to have_content(patient.address.street)
		end
		
		it "shows Address Line 2" do
			expect(rendered).to have_content(patient.address.address_line2)
		end
		
		it "shows City" do
			expect(rendered).to have_content(patient.address.city)
		end
		
		it "shows County" do
			expect(rendered).to have_content(patient.address.county)
		end
		
		it "shows Post Code" do
			expect(rendered).to have_content(patient.address.post_code)
		end
		
		it "shows Phone number" do
			expect(rendered).to have_content("(012) 345-6789")
		end

		it "should show Date Created" do
			expect(rendered).to have_content(patient.created_at.strftime("%d %B %Y %H:%M:%S"))
		end

		it "should show Date Last Modified" do
			expect(rendered).to have_content(patient.updated_at.strftime("%d %B %Y %H:%M:%S"))
		end

	end

	context "Patient" do
		before(:each) do
			assign(:current_user, patient)
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end

		it "shouldn't have a back to patients button" do
			expect(rendered).to_not have_link("<< Back to Patients", href: patients_path)
		end
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end

		it "should have a back to patients button" do
			expect(rendered).to have_link("<< Back to Patients", href: patients_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "should have a Back to Patients button" do
			expect(rendered).to have_link("<< Back to Patients", href: patients_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end
	
	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "should have a back to patients button" do
			expect(rendered).to have_link("<< Back to Patients", href: patients_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
		
		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end

end
