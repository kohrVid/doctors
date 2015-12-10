require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
	let(:user) { FactoryGirl.create(:user) }
	let(:patient) { FactoryGirl.create(:patient) }
	context "Admin" do	
		before(:each) do
			assign(:user, user)
			@users = User.all
			@current_user = FactoryGirl.create(:admin)
			render :template => "users/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Users")
		end
		
		it "has a Name" do
			expect(rendered).to have_content("Name")
		end

		it "has a Username" do
			expect(rendered).to have_content("Username")
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
	end

	context "Doctor" do
		before(:each) do
			assign(:user, user)
			@users = User.all
			@current_user = FactoryGirl.create(:doctor)
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
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:user, user)
			@users = User.all
			@current_user = FactoryGirl.create(:receptionist)
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
	end
end
