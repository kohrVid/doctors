require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
	context "attributes" do
		before(:each) do
		      @user = FactoryGirl.create(:user)
		      assign(:user, @user)
		      render :template => "users/show", :layout => "layouts/application", :id => @user.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Tobey Torres")
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

		it "shows Date of Birth" do
			expect(rendered).to have_content("Date of Birth")
		end

		it "shows Age" do
			expect(rendered).to have_content("Age")
			expect(rendered).to have_content(DateTime.now.year - @user.dob.year)
		end

		it "shows Username" do
			expect(rendered).to have_content("Username")
		end
		
		it "shows Email Address" do
			expect(rendered).to have_content("Email Address")
		end
		
		it "shows input for Street" do
			expect(rendered).to have_content("Street")
		end
		
		it "shows Address Line 2" do
			expect(rendered).to have_content("#{@user.address.address_line2}")
		end
		
		it "shows City" do
			expect(rendered).to have_content("City")
		end
		
		it "shows County" do
			expect(rendered).to have_content("County")
		end
		
		it "shows Post Code" do
			expect(rendered).to have_content("Post Code")
		end
		
		it "shows Phone number" do
			expect(rendered).to have_content("Phone")
		end

	end

	context "Patient" do
		before(:each) do
			@current_user = FactoryGirl.create(:user)
			assign(:user, @current_user)
			render :template => "users/show", :layout => "layouts/application", :id => @current_user.id
		end

		it "shouldn't have a back to users button" do
			expect(rendered).to_not have_link("a", href: users_path, text: "<< Back to Users")
		end
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(@current_user))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			assign(:user, @user)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "users/show", :layout => "layouts/application", :id => @user.id
		end

		it "should have a back to users button" do
			expect(rendered).to have_link("a", href: users_path, text: "<< Back to Users")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(@user))
		end
	end

	context "Doctor" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			assign(:user, @user)
			@current_user = FactoryGirl.create(:doctor)
			render :template => "users/show", :layout => "layouts/application", :id => @user.id
		end
		
		it "should have a back to users button" do
			expect(rendered).to have_link("a", href: users_path, text: "<< Back to Users")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(@user))
		end
	end
	
	context "Admin" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			assign(:user, @user)
			@current_user = FactoryGirl.create(:admin)
			render :template => "users/show", :layout => "layouts/application", :id => @user.id
		end
		
		it "should have a back to users button" do
			expect(rendered).to have_link("a", href: users_path, text: "<< Back to Users")
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(@user))
		end
	end
	
#show nhs number in 3-3-4 format

end
