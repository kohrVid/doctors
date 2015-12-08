require 'rails_helper'

RSpec.describe "user_sessions/new.html.erb", type: :view do
	before(:each) do
		u = FactoryGirl.create(:user)
		assign(:user, u)
		render :template => "user_sessions/new", :layout => "layouts/application"
	end
	
	it "must display the full title of page" do
		expect(rendered).to have_title("The Doctor's | Log In")
	end
	
	it "has a form posting to /user_sessions" do
		expect(rendered).to have_selector("form")
	end

	it "has an input for username" do
		expect(rendered).to have_selector("input[name*=username]")
	end

	it "has an input for password" do
		expect(rendered).to have_selector("input[name*=password]")
	end

	it "should display a submit button" do
		expect(rendered).to have_selector("input[name*=commit]")
	end


end

