require 'rails_helper'

RSpec.describe "pages/show.html.erb", type: :view do
	let(:page) { FactoryGirl.create(:page) }

	before(:each) do
		assign(:page, page)
	end
	
	context "attributes" do 
		before(:each) do
			render :template => "pages/show", :layout => "layouts/application", :id => page.id
		end

		it "should display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Medical Info")
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("HomeMedical Info")
		end

		it "should display the page's title" do
			expect(rendered).to have_content("Medical Info")
		end

		it "should display the page's content" do
			expect(rendered).to have_content("This valuable medical information for NHS patients")
		end
		
		it "should have a back to testimonials button" do
			expect(rendered).to have_link("<< Back to Pages", href: pages_path)
		end
	end

	context "Doctor" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor))
			render :template => "pages/show", :layout => "layouts/application", :id => page.id
		end

		it "should show Edit button" do
			expect(rendered).to have_link("Edit", href: edit_page_path(page))
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end

	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			render :template => "pages/show", :layout => "layouts/application", :id => page.id
		end

		it "should show Edit button" do
			expect(rendered).to have_link("Edit", href: edit_page_path(page))
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
	end
end
