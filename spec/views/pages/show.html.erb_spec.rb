require 'rails_helper'

RSpec.describe "pages/show.html.erb", type: :view do
	let(:page) { FactoryGirl.create(:page) }
	before(:each) do
		assign(:page, page)
		render :template => "pages/show", :layout => "layouts/application", :id => page.id
	end

	it "should display the full title of page" do
		expect(rendered).to have_title("The Doctor's | Medical Info")
	end

	it "should display the page's title" do
		expect(rendered).to have_content("Medical Info")
	end

	it "should display the page's content" do
		expect(rendered).to have_content("This valuable medical information for NHS patients")
	end
end
