require 'rails_helper'

RSpec.describe "search/search.html.erb", type: :view do
	let (:user) { FactoryGirl.create(:user) }

	before(:each) do
		assign(:q, "Test")
		assign(:results, Page.search("Test"))
		render :template => "search/search", :layout => "layouts/application"
	end
	
	it "must display the full title of page" do
		expect(rendered).to have_title("The Doctor's | Search Results")
	end
	
	it "must display the correct breadcrumb" do
		expect(rendered).to have_content("You are here: HomeSearch Results")
	end
	
	it "has a form posting to /search" do
		expect(rendered).to have_selector("form")
	end

	it "has an input for Search term" do
		expect(rendered).to have_selector("input[name*=q]")
	end
end

