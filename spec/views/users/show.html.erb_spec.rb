require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
	let(:user)  { FactoryGirl.create(:user) }
	context "attributes" do
		before(:each) do
		      assign(:user, user)
		      render :template => "users/show", :layout => "layouts/application", :id => user.id
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Tobey Torres")
		end
		
		it "shows Title" do
			expect(rendered).to have_content(user.title)
		end

		it "shows First Name" do
			expect(rendered).to have_content(user.first_name)
		end
		
		it "shows Middle Name" do
			expect(rendered).to have_content(user.middle_name)
		end

		it "shows Last Name" do
			expect(rendered).to have_content(user.last_name)
		end

		it "shows Date of Birth" do
			expect(rendered).to have_content(user.dob.strftime("%d %B %Y"))
		end

		it "shows Age" do
			expect(rendered).to have_content(DateTime.now.year - user.dob.year)
		end

		it "shows Username" do
			expect(rendered).to have_content(user.username)
		end
		
		it "shows Email Address" do
			expect(rendered).to have_content(user.email)
		end
		
		it "shows input for Street" do
			expect(rendered).to have_content(user.address.street)
		end
		
		it "shows Address Line 2" do
			expect(rendered).to have_content(user.address.address_line2)
		end
		
		it "shows City" do
			expect(rendered).to have_content(user.address.city)
		end
		
		it "shows County" do
			expect(rendered).to have_content(user.address.county)
		end
		
		it "shows Post Code" do
			expect(rendered).to have_content(user.address.post_code)
		end
		
		it "shows Phone number" do
			expect(rendered).to have_content("(012) 345-6789")
		end

		it "should show Date Created" do
			expect(rendered).to have_content(user.created_at.strftime("%d %B %Y %H:%M:%S"))
		end

		it "should show Date Last Modified" do
			expect(rendered).to have_content(user.updated_at.strftime("%d %B %Y %H:%M:%S"))
		end
	end

	context "Patient" do
		before(:each) do
			assign(:user, user)
			@current_user = user
			render :template => "users/show", :layout => "layouts/application", :id => @current_user.id
		end

		it "shouldn't have a back to users button" do
			expect(rendered).to_not have_link("<< Back to Users", href: users_path)
		end
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(@current_user))
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:user, user)
			@current_user = FactoryGirl.create(:receptionist)
			render :template => "users/show", :layout => "layouts/application", :id => user.id
		end

		it "should have a back to users button" do
			expect(rendered).to have_link("<< Back to Users", href: users_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:user, user)
			@current_user = FactoryGirl.create(:doctor)
			render :template => "users/show", :layout => "layouts/application", :id => user.id
		end
		
		it "should have a back to users button" do
			expect(rendered).to have_link("<< Back to Users", href: users_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end
	end
	
	context "Admin" do
		before(:each) do
			assign(:user, user)
			@current_user = FactoryGirl.create(:admin)
			render :template => "users/show", :layout => "layouts/application", :id => user.id
		end
		
		it "should have a back to users button" do
			expect(rendered).to have_link("<< Back to Users", href: users_path)
		end
		
		it "shows edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end
		
		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end
end
