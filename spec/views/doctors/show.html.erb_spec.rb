require 'rails_helper'

RSpec.describe "doctors/show.html.erb", type: :view do
	context "Non-Users" do
		before(:each) do
		      @doctor = FactoryGirl.create(:doctor)
		      assign(:doctor, @doctor)
		      render :template => "doctors/show", :layout => "layouts/application", :id => @doctor.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Dr Eric Hammer")
		end
		
		it "should not show Title" do
			expect(rendered).to_not have_content("Title")
		end

		it "should not show First Name" do
			expect(rendered).to_not have_content("First Name")
		end
		
		it "should not show Middle Name" do
			expect(rendered).to_not have_content("Middle Name")
		end

		it "should not show Last Name" do
			expect(rendered).to_not have_content("Last Name")
		end

		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content("Date of Birth")
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content("Age")
			expect(rendered).to_not have_content(DateTime.now.year - @doctor.dob.year)
		end

		it "shouldn't shows Username" do
			expect(rendered).to_not have_content("Username")
		end
		
		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content("Email Address")
		end
		
		it "shouldn't show input for Street" do
			expect(rendered).to_not have_content("Street")
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content("City")
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content("County")
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content("Post Code")
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("Phone")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(@doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

	context "Patient" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			assign(:doctor, @doctor)
			@current_user = FactoryGirl.create(:patient)
			render :template => "doctors/show", :layout => "layouts/application", :id => @doctor.id
		end
		
		it "should not show Title" do
			expect(rendered).to_not have_content("Title")
		end

		it "should not show First Name" do
			expect(rendered).to_not have_content("First Name")
		end
		
		it "should not show Middle Name" do
			expect(rendered).to_not have_content("Middle Name")
		end

		it "should not show Last Name" do
			expect(rendered).to_not have_content("Last Name")
		end

		
		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content("Date of Birth")
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content("Age")
			expect(rendered).to_not have_content(DateTime.now.year - @doctor.dob.year)
		end

		it "shouldn't show Username" do
			expect(rendered).to_not have_content("Username")
		end
		
		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content("Email Address")
		end
		
		it "shouldn't show input for Street" do
			expect(rendered).to_not have_content("Street")
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content("City")
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content("County")
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content("Post Code")
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("Phone")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(@doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			assign(:doctor, @doctor)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "doctors/show", :layout => "layouts/application", :id => @doctor.id
		end
		
		it "should not show Title" do
			expect(rendered).to_not have_content("Title")
		end

		it "should not show First Name" do
			expect(rendered).to_not have_content("First Name")
		end
		
		it "should not show Middle Name" do
			expect(rendered).to_not have_content("Middle Name")
		end

		it "should not show Last Name" do
			expect(rendered).to_not have_content("Last Name")
		end

		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content("Date of Birth")
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content("Age")
			expect(rendered).to_not have_content(DateTime.now.year - @doctor.dob.year)
		end

		it "shouldn't show Username" do
			expect(rendered).to_not have_content("Username")
		end
		
		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content("Email Address")
		end
		
		it "shouldn't show input for Street" do
			expect(rendered).to_not have_content("Street")
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content("City")
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content("County")
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content("Post Code")
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("Phone")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(@doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

	context "Doctor" do
		before(:each) do
			@current_user = FactoryGirl.create(:doctor)
			assign(:doctor, @current_user)
			render :template => "doctors/show", :layout => "layouts/application", :id => @current_user.id
		end
		
		it "shows Title" do
			expect(rendered).to have_content("Title")
		end

		it "shows First Name" do
			expect(rendered).to have_content("First Name")
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content("Middle Name")
		end

		it "shows Last Name" do
			expect(rendered).to have_content("Last Name")
		end
		it "should show Date of Birth" do
			expect(rendered).to have_content("Date of Birth")
		end

		it "should show Age" do
			expect(rendered).to have_content("Age")
			expect(rendered).to have_content(DateTime.now.year - @current_user.dob.year)
		end

		it "should show Username" do
			expect(rendered).to have_content("Username")
		end
		
		it "should show Email Address" do
			expect(rendered).to have_content("Email Address")
		end
		
		it "should show input for Street" do
			expect(rendered).to have_content("Street")
		end
		
		it "should show City" do
			expect(rendered).to have_content("City")
		end
		
		it "should show County" do
			expect(rendered).to have_content("County")
		end
		
		it "should show Post Code" do
			expect(rendered).to have_content("Post Code")
		end
		
		it "should show Phone number" do
			expect(rendered).to have_content("Phone")
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
			@doctor = FactoryGirl.create(:doctor)
			assign(:doctor, @doctor)
			@current_user = FactoryGirl.create(:doctor, username: "drgirlfriend", email: "drgirlfriend@thehospital.com")
			render :template => "doctors/show", :layout => "layouts/application", :id => @doctor.id
		end
		
		it "should not show Title" do
			expect(rendered).to_not have_content("Title")
		end

		it "should not show First Name" do
			expect(rendered).to_not have_content("First Name")
		end
		
		it "should not show Middle Name" do
			expect(rendered).to_not have_content("Middle Name")
		end

		it "should not show Last Name" do
			expect(rendered).to_not have_content("Last Name")
		end

		it "shouldn't show Date of Birth" do
			expect(rendered).to_not have_content("Date of Birth")
		end

		it "shouldn't show Age" do
			expect(rendered).to_not have_content("Age")
			expect(rendered).to_not have_content(DateTime.now.year - @doctor.dob.year)
		end

		it "shouldn't shows Username" do
			expect(rendered).to_not have_content("Username")
		end
		
		it "shouldn't show Email Address" do
			expect(rendered).to_not have_content("Email Address")
		end
		
		it "shouldn't show input for Street" do
			expect(rendered).to_not have_content("Street")
		end
		
		it "shouldn't show City" do
			expect(rendered).to_not have_content("City")
		end
		
		it "shouldn't show County" do
			expect(rendered).to_not have_content("County")
		end
		
		it "shouldn't show Post Code" do
			expect(rendered).to_not have_content("Post Code")
		end
		
		it "shouldn't show Phone number" do
			expect(rendered).to_not have_content("Phone")
		end

		it "shouldn't show edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_doctor_path(@doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
		
	end
	
	context "Admin" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			assign(:doctor, @doctor)
			@current_user = FactoryGirl.create(:admin)
			render :template => "doctors/show", :layout => "layouts/application", :id => @doctor.id
		end
		
		it "shows Title" do
			expect(rendered).to have_content("Title")
		end

		it "shows First Name" do
			expect(rendered).to have_content("First Name")
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content("Middle Name")
		end

		it "shows Last Name" do
			expect(rendered).to have_content("Last Name")
		end
		it "should show Date of Birth" do
			expect(rendered).to have_content("Date of Birth")
		end

		it "should show Age" do
			expect(rendered).to have_content("Age")
			expect(rendered).to have_content(DateTime.now.year - @doctor.dob.year)
		end

		it "should show Username" do
			expect(rendered).to have_content("Username")
		end
		
		it "should show Email Address" do
			expect(rendered).to have_content("Email Address")
		end
		
		it "should show input for Street" do
			expect(rendered).to have_content("Street")
		end
		
		it "should show City" do
			expect(rendered).to have_content("City")
		end
		
		it "should show County" do
			expect(rendered).to have_content("County")
		end
		
		it "should show Post Code" do
			expect(rendered).to have_content("Post Code")
		end
		
		it "should show Phone number" do
			expect(rendered).to have_content("Phone")
		end

		it "should show edit button" do
			expect(rendered).to have_link("Edit", href: edit_doctor_path(@doctor))
		end
		
		it "should have a back to doctors button" do
			expect(rendered).to have_link("a", href: doctors_path, text: "<< Back to Doctors")
		end
	end

end
