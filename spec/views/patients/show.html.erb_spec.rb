require 'rails_helper'

RSpec.describe "patients/show.html.erb", type: :view do
	let(:patient) { FactoryGirl.create(:patient) }
	context "attributes" do
		before(:each) do
		      assign(:patient, patient)
		      render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Jason Slater")
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
			expect(rendered).to have_content(patient.dob.strftime("%v"))
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

	end

	context "Patient" do
		before(:each) do
			@current_user = patient
			assign(:patient, @current_user)
			render :template => "patients/show", :layout => "layouts/application", :id => @current_user.id
		end

		it "shouldn't have a back to patients button" do
			expect(rendered).to_not have_link("a", href: patients_path, text: "<< Back to Patients")
		end
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(@current_user))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:patient, patient)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end

		it "should have a back to patients button" do
			expect(rendered).to have_link("a", href: patients_path, text: "<< Back to Patients")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:patient, patient)
			@current_user = FactoryGirl.create(:doctor)
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "should have a Back to Patients button" do
			expect(rendered).to have_link("a", href: patients_path, text: "<< Back to Patients")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end
	
	context "Admin" do
		before(:each) do
			assign(:patient, patient)
			@current_user = FactoryGirl.create(:admin)
			render :template => "patients/show", :layout => "layouts/application", :id => patient.id
		end
		
		it "should have a back to patients button" do
			expect(rendered).to have_link("a", href: patients_path, text: "<< Back to Patients")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_patient_path(patient))
		end
	end

end
