require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
	let(:user) { FactoryGirl.create(:user) }
	let(:patient) { FactoryGirl.create(:patient) }

	before(:each) do
		assign(:user, user)
		assign(:users, User.all)
	end
	
	context "Patient" do	
		before(:each) do
			assign(:current_user, FactoryGirl.create(:patient))
			render :template => "users/index", :layout => "layouts/application"
		end
		
		it "must not see Name" do
			expect(rendered).to_not have_content(user.full_name)
		end

		it "must not see Username" do
			expect(rendered).to_not have_content(user.username)
		end
		
		it "must not have a show button" do
			expect(rendered).to_not have_link("Show", href: user_path(user))
		end

		it "must not have an edit button" do
			expect(rendered).to_not have_link("Edit", href: edit_user_path(user))
		end

		it "must not have a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "has no Add New User button" do
			expect(rendered).to_not have_link("Add User", href: new_user_path)
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "users/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: user_path(user))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "has no Add New User button" do
			expect(rendered).to_not have_link("Add User", href: new_user_path)
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "users/index", :layout => "layouts/application"
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: user_path(user))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end
		
		it "has no a destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
		
		it "has no Add New User button" do
			expect(rendered).to_not have_link("Add New User", href: new_user_path)
		end
	end

	context "Admin" do	
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "users/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Users")
		end
		
		it "has a Name" do
			expect(rendered).to have_content(user.full_name)
		end

		it "has a Username" do
			expect(rendered).to have_content(user.username)
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: user_path(user))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end

		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "has an Add New User button" do
			expect(rendered).to have_link("Add New User", href: new_user_path)
		end
	end
end
