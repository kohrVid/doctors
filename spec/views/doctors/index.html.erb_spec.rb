require 'rails_helper'

RSpec.describe "doctors/index.html.erb", type: :view do
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:doctor2) { FactoryGirl.create(:doctor, username: "drgirlfriend", email: "drgirlfriend@thehospital.com") }
	context "Admin" do	
		before(:each) do
			assign(:doctor, doctor)
			@doctors = Doctor.all.where(doctor: true)
			@current_user = FactoryGirl.create(:admin)
			render :template => "doctors/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Your Doctors")
		end
		
		it "has a Name" do
			expect(rendered).to have_content("Name")
		end

		it "has a Username" do
			expect(rendered).to have_content("Username")
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: doctor_path(doctor))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_doctor_path(doctor))
		end

		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:doctor, doctor)
			assign(:doctor2, doctor2)
			@doctors = Doctor.all.where(doctor: true)
			@current_user = doctor
			render :template => "doctors/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: doctor_path(doctor))
		end

		it "has an edit button for itself" do
			expect(rendered).to have_link("Edit", href: edit_doctor_path(doctor))
		end
		it "doesn't have an edit button for other Doctors" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor2))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:doctor, doctor)
			@doctors = Doctor.all.where(doctor: true)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "doctors/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: doctor_path(doctor))
		end

		it "doesn't have an edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end
	
	context "Patient" do
		before(:each) do
			assign(:doctor, doctor)
			@doctors = Doctor.all.where(doctor: true)
			@current_user = FactoryGirl.create(:patient)
			render :template => "doctors/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: doctor_path(doctor))
		end

		it "doesn't have an edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end
end
