require 'rails_helper'

RSpec.describe "doctors/show.html.erb", type: :view do
	let(:doctor) { FactoryGirl.create(:doctor) }
	context "Non-Users" do
		before(:each) do
			@doctor = doctor
			assign(:doctor, doctor)
			render :template => "doctors/show", :layout => "layouts/application", :id => doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Dr Eric Hammer")
		end

		it "should show Doctor's name" do
			expect(rendered).to have_content(doctor.title + " " + doctor.first_name_last_name)
		end

		it "should show the Doctor's biography" do
			expect(rendered).to have_content(doctor.biography)
		end
		
		it "should not show Title" do
			expect(rendered).to_not have_content("Title: "+ doctor.title)
		end

		it "should not show First Name" do
			expect(rendered).to_not have_content("First Name: " + doctor.first_name)
		end
		
		it "should not show Middle Name" do
			expect(rendered).to_not have_content(doctor.middle_name)
		end

		it "should not show Last Name" do
			expect(rendered).to_not have_content("Middle Name: " + doctor.last_name)
		end

		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content(doctor.dob.strftime("%d %B %Y"))
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content(DateTime.now.year - doctor.dob.year)
		end

		it "shouldn't shows Username" do
			expect(rendered).to_not have_content(doctor.username)
		end
		
		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content(doctor.email)
		end
		
		it "shouldn't show for Street" do
			expect(rendered).to_not have_content(doctor.address.street)
		end
	
		it "shouldn't show for Address Line 2" do
			expect(rendered).to_not have_content(doctor.address.address_line2)
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content(doctor.address.city)
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content(doctor.address.county)
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content(doctor.address.post_code)
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("(012) 345-6789")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

	context "Patient" do
		before(:each) do
			@doctor = doctor
			assign(:doctor, doctor)
			@current_user = FactoryGirl.create(:patient)
			render :template => "doctors/show", :layout => "layouts/application", :id => doctor.id
		end
		
		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content(doctor.dob.strftime("%d %B %Y"))
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content(DateTime.now.year - doctor.dob.year)
		end

		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content(doctor.email)
		end
		
		it "shouldn't show for Street" do
			expect(rendered).to_not have_content(doctor.address.street)
		end
	
		it "shouldn't show for Address Line 2" do
			expect(rendered).to_not have_content(doctor.address.address_line2)
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content(doctor.address.city)
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content(doctor.address.county)
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content(doctor.address.post_code)
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("(012) 345-6789")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			@doctor = doctor
			assign(:doctor, doctor)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "doctors/show", :layout => "layouts/application", :id => doctor.id
		end
		
		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content(doctor.dob.strftime("%d %B %Y"))
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content(DateTime.now.year - doctor.dob.year)
		end

		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content(doctor.email)
		end
		
		it "shouldn't show for Street" do
			expect(rendered).to_not have_content(doctor.address.street)
		end
	
		it "shouldn't show for Address Line 2" do
			expect(rendered).to_not have_content(doctor.address.address_line2)
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content(doctor.address.city)
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content(doctor.address.county)
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content(doctor.address.post_code)
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("(012) 345-6789")
		end


		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

	context "Doctor" do
		before(:each) do
			@doctor = doctor
			@current_user = doctor
			assign(:doctor, @current_user)
			render :template => "doctors/show", :layout => "layouts/application", :id => @current_user.id
		end
		
		it "shows Title" do
			expect(rendered).to have_content(@current_user.title)
		end

		it "shows First Name" do
			expect(rendered).to have_content(@current_user.first_name)
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content(@current_user.middle_name)
		end

		it "shows Last Name" do
			expect(rendered).to have_content(@current_user.last_name)
		end
		it "should show Date of Birth" do
			expect(rendered).to have_content(@current_user.dob.strftime("%d %B %Y"))
		end

		it "should show Age" do
			expect(rendered).to have_content(DateTime.now.year - @current_user.dob.year)
		end

		it "should show Username" do
			expect(rendered).to have_content(@current_user.username)
		end
		
		it "should show Email Address" do
			expect(rendered).to have_content(@current_user.email)
		end
		
		it "should show input for Street" do
			expect(rendered).to have_content(@current_user.address.street)
		end
		
		it "should show City" do
			expect(rendered).to have_content(@current_user.address.city)
		end
		
		it "should show County" do
			expect(rendered).to have_content(@current_user.address.county)
		end
		
		it "should show Post Code" do
			expect(rendered).to have_content(@current_user.address.post_code)
		end
		
		it "should show Phone number" do
			expect(rendered).to have_content("(012) 345-6789")
		end
		
		it "should show Date Created" do
			expect(rendered).to have_content(doctor.created_at.strftime("%d %B %Y %H:%M:%S"))
		end

		it "should show Date Last Modified" do
			expect(rendered).to have_content(doctor.updated_at.strftime("%d %B %Y %H:%M:%S"))
		end


		it "should show edit button" do
			expect(rendered).to have_link("Edit", href: edit_doctor_path(@current_user))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

	context "Other Doctors" do
		before(:each) do
			@doctor = doctor
			assign(:doctor, doctor)
			@current_user = FactoryGirl.create(:doctor, username: "drmrsthemonarch", email: "drmrsthemonarch@thehospital.com")
			render :template => "doctors/show", :layout => "layouts/application", :id => doctor.id
		end
		
		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content(doctor.dob.strftime("%d %B %Y"))
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content(DateTime.now.year - doctor.dob.year)
		end

		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content(doctor.email)
		end
		
		it "shouldn't show for Street" do
			expect(rendered).to_not have_content(doctor.address.street)
		end
	
		it "shouldn't show for Address Line 2" do
			expect(rendered).to_not have_content(doctor.address.address_line2)
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content(doctor.address.city)
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content(doctor.address.county)
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content(doctor.address.post_code)
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("(012) 345-6789")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
		
	end
	
	context "Admin" do
		before(:each) do
			@doctor = doctor
			assign(:doctor, doctor)
			@current_user = FactoryGirl.create(:admin)
			render :template => "doctors/show", :layout => "layouts/application", :id => doctor.id
		end
		
		it "shows Title" do
			expect(rendered).to have_content(doctor.title)
		end

		it "shows First Name" do
			expect(rendered).to have_content(doctor.first_name)
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content(doctor.middle_name)
		end

		it "shows Last Name" do
			expect(rendered).to have_content(doctor.last_name)
		end
		it "should show Date of Birth" do
			expect(rendered).to have_content(doctor.dob.strftime("%d %B %Y"))
		end

		it "should show Age" do
			expect(rendered).to have_content(DateTime.now.year - doctor.dob.year)
		end

		it "should show Username" do
			expect(rendered).to have_content(doctor.username)
		end
		
		it "should show Email Address" do
			expect(rendered).to have_content(doctor.email)
		end
		
		it "should show input for Street" do
			expect(rendered).to have_content(doctor.address.street)
		end
		
		it "should show City" do
			expect(rendered).to have_content(doctor.address.city)
		end
		
		it "should show County" do
			expect(rendered).to have_content(doctor.address.county)
		end
		
		it "should show Post Code" do
			expect(rendered).to have_content(doctor.address.post_code)
		end
		
		it "should show Phone number" do
			expect(rendered).to have_content("(012) 345-6789")
		end

		it "should show Date Created" do
			expect(rendered).to have_content(doctor.created_at.strftime("%d %B %Y %H:%M:%S"))
		end

		it "should show Date Last Modified" do
			expect(rendered).to have_content(doctor.updated_at.strftime("%d %B %Y %H:%M:%S"))
		end

		it "should show edit button" do
			expect(rendered).to have_link("Edit", href: edit_doctor_path(doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
		
		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end
end
