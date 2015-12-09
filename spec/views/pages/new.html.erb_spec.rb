require 'rails_helper'

RSpec.describe "pages/new.html.erb", type: :view do
	before(:each) do
		d = FactoryGirl.create(:doctor)
		assign(:doctor, d)
		render :template => "pages/new", :layout => "layouts/application"
	end
	
	it "must display the full title of page" do
		expect(rendered).to have_title("The Doctor's | New Page")
	end
	
	it "has a form posting to /pages" do
		expect(rendered).to have_selector("form")
	end

	it "has an input for Title" do
		expect(rendered).to have_selector("input[name*=title]")
	end

	it "has an input for Description" do
		expect(rendered).to have_selector("textarea[name*=description]")
	end

	it "should display a submit button" do
		expect(rendered).to have_selector("input[name*=commit]")
	end
end
