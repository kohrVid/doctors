require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
		before(:each) do
			user = FactoryGirl.create(:user)
			assign(:user, user)
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
			expect(rendered).to have_selector("Username")
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: user_path(user))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_user_path(user))
		end

		it "has a destroy button" do
			expect(rendered).to have_link("a", text: "Destroy", method: :delete)
		end

		it "should not have a Receptionist boolean" do
			expect(rendered).to_not have_selector("input[name*=receptionist]")
		end
		
		it "should not have a Doctor boolean" do
			expect(rendered).to_not have_selector("input[name*=doctor]")
		end
		
		it "should not have an Admin boolean" do
			expect(rendered).to_not have_selector("input[name*=admin]")
		end
end
