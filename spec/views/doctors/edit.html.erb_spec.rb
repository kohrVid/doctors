require 'rails_helper'

RSpec.describe "doctors/edit.html.erb", type: :view do
	context "attributes" do
		before(:each) do
			doctor = FactoryGirl.create(:doctor)
			assign(:doctor, doctor)
			render :template => "doctors/edit", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Edit Doctor")
		end
		
		it "has a form posting to /doctors" do
			expect(response).to have_selector("form")
		end

		it "has an input for Title" do
			expect(response).to have_selector("input[name*=title]")
		end

		it "has an input for First Name" do
			expect(rendered).to have_selector("input[name*=first_name]")
		end
		
		it "has an input for Middle Name" do
			expect(rendered).to have_selector("input[name*=middle_name]")
		end

		it "has an input for Last Name" do
			expect(rendered).to have_selector("input[name*=last_name]")
		end

		it "has an input for Date of Birth" do
			expect(rendered).to have_selector("select[name*=dob]")
		end

		it "has an input for Biography" do
			expect(rendered).to have_selector("textarea[name*=biography]")
		end

		it "has an input for Username" do
			expect(rendered).to have_selector("input[name*=username]")
		end
		
		it "has an input for Email Address" do
			expect(rendered).to have_selector("input[name*=email]")
		end
		
		it "has an input for Password" do
			expect(rendered).to have_selector("input[name*=password]")
		end
		
		it "has an input for Password Confirmation" do
			expect(rendered).to have_selector("input[name*=password_confirmation]")
		end
		
		it "has an input for Street" do
			expect(rendered).to have_selector("input[name*=street]")
		end
		
		it "has an input for Address Line 2" do
			expect(rendered).to have_selector("input[name*=address_line2]")
		end
		
		it "has an input for City" do
			expect(rendered).to have_selector("input[name*=city]")
		end
		
		it "has an input for County" do
			expect(rendered).to have_selector("input[name*=county]")
		end
		
		it "has an input for Post Code" do
			expect(rendered).to have_selector("input[name*=post_code]")
		end
		
		it "has an input for Phone" do
			expect(rendered).to have_selector("input[name*=phone]")
		end

		it "should display a submit button" do
			expect(rendered).to have_selector("input[name*=commit]")
		end
	end
	
	context "Doctor" do
		before(:each) do
			doctor = FactoryGirl.create(:doctor)
			assign(:doctor, doctor)
			@current_user = doctor
			render :template => "doctors/edit", :layout => "layouts/application"
		end
		
		it "should not have an Approval boolean" do
			expect(rendered).to_not have_selector("input[name*=approved]")
		end
		
		it "should have a back to Doctors button" do
			expect(rendered).to have_link("a", text: "<< Back to Doctors", href: doctors_path)
		end
		
		it "should not have a Locked boolean" do
			expect(rendered).to_not have_selector("input[name*=locked]")
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end

	context "Admin" do
		before(:each) do
			doctor = FactoryGirl.create(:doctor)
			assign(:doctor, doctor)
			@current_user = FactoryGirl.create(:admin)
			render :template => "doctors/edit", :layout => "layouts/application"
		end
		
		it "should have an Approval boolean" do
			expect(rendered).to have_selector("input[name*=approved]")
		end

		it "should have a Receptionist boolean" do
			expect(rendered).to have_selector("input[name*=receptionist]")
		end
		
		it "should have a Doctor boolean" do
			expect(rendered).to have_selector("input[name*=doctor]")
		end
		
		it "should have an Admin boolean" do
			expect(rendered).to have_selector("input[name*=admin]")
		end
		
		it "should have a Back to Doctors button" do
			expect(rendered).to have_link("a", text: "<< Back to Doctors", href: doctors_path)
		end
		
		it "should have a Locked boolean" do
			expect(rendered).to have_selector("input[name*=locked]")
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end
end
