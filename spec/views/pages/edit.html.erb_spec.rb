require 'rails_helper'

RSpec.describe "pages/edit.html.erb", type: :view do
	let(:page) { FactoryGirl.create(:page) }

	context "Admin" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:admin))
			assign(:page, page)
			render :template => "pages/edit", :layout => "layouts/application", id: page.id
		end
		
		it "must display the correct breadcrumb" do
			expect(rendered).to have_content("HomeMedical InfoEdit Medical Info")
		end
		
		it "has an input for Description" do
			expect(response).to have_selector("textarea[name*=description]")
		end

		it "should display a Submit button" do
			expect(rendered).to have_selector("input[name*=commit]")
		end
		
		it "should have a Destroy button" do
			expect(rendered).to have_link("Destroy")
		end
		
		it "should have a Back to Pages button" do
			expect(rendered).to have_link("<< Back to Pages", href: pages_path)
		end
		
		it "should have a link to the Testimonial's show page" do
			expect(rendered).to have_link("Show Medical Info", href: page_path(page))
		end
	end
	
	context "Doctor" do
		before(:each) do
			assign(:current_user, FactoryGirl.create(:doctor))
			assign(:page, page)
			render :template => "pages/edit", :layout => "layouts/application", id: page.id
		end
		
		it "should not have a Destroy button" do
			expect(rendered).to_not have_link("Destroy")
		end
	end
end
