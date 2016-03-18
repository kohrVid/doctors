require 'rails_helper'

RSpec.describe "users/bulk_approval.html.erb", type: :view do
	let(:user) { FactoryGirl.create(:user, approved: false) }

	before(:each) do
		assign(:user, user)
		assign(:users, User.where(approved: false))
	end
	
	context "Patient" do	
		before(:each) do
			assign(:current_user, FactoryGirl.create(:patient))
			render :template => "users/bulk_approval", :layout => "layouts/application"
		end
		
		it "must not see Name" do
			expect(rendered).to_not have_content(user.full_name)
		end

		it "must not see Username" do
			expect(rendered).to_not have_link(user.full_name, href: user_path(user))
		end
		
		it "must not have an Approval boolean" do
			expect(rendered).to_not have_selector("input[name*=approved]")
		end

		it "must not have a Locked boolean" do
			expect(rendered).to_not have_selector("input[name*=locked]")
		end
	end
	
	context "Receptionist" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:receptionist))
			render :template => "users/bulk_approval", :layout => "layouts/application"
		end
		
		it "must not see Username" do
			expect(rendered).to_not have_link(user.full_name, href: user_path(user))
		end
		
		it "must not have an Approval boolean" do
			expect(rendered).to_not have_selector("input[name*=approved]")
		end

		it "must not have a Locked boolean" do
			expect(rendered).to_not have_selector("input[name*=locked]")
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "users/bulk_approval", :layout => "layouts/application"
		end
		
		it "must not see Username" do
			expect(rendered).to_not have_link(user.full_name, href: user_path(user))
		end
		
		it "must not have an Approval boolean" do
			expect(rendered).to_not have_selector("input[name*=approved]")
		end

		it "must not have a Locked boolean" do
			expect(rendered).to_not have_selector("input[name*=locked]")
		end
	end

	context "Admin" do	
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "users/bulk_approval", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(response).to have_title("The Doctor's | Bulk User Approval")
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("You are here: HomeUsersBulk User Approval")
		end
		
		it "must see Name" do
			expect(rendered).to have_content(user.full_name)
		end

		it "must see Username" do
			expect(rendered).to have_link(user.full_name, href: user_path(user))
		end
		
		it "must have an Approval boolean" do
			expect(rendered).to have_selector("input[name*=approved]")
		end

		it "must have a Locked boolean" do
			expect(rendered).to have_selector("input[name*=locked]")
		end
	end
end
