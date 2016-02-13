require 'rails_helper'

RSpec.describe "contacts/new.html.erb", type: :view do
	before(:each) do
		assign(:contact, Contact.new)
		render :template => "contacts/new", :layout => "layouts/application"
	end
	
	it "must display the correct breadcrumb" do
		expect(rendered).to have_content("You are here: HomeGet In Touch")
	end
	
	it "should have a Name text field" do
		expect(rendered).to have_selector("input[name*=name]")
	end
	
	it "should have an Email Address text field" do
		expect(rendered).to have_selector("input[name*=email]")
	end
	
	it "should have a Message textarea" do
		expect(rendered).to have_selector("textarea[name*=message]")
	end
	
	it "should not have a Nickname text field" do
		expect(rendered).to have_selector("input[name*=nickname]")
	end
	
	it "should display a send button" do
		expect(rendered).to have_selector("input[name*=commit]")
	end
	
end
