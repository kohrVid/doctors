require 'rails_helper'

RSpec.describe "contacts/thanks.html.erb", type: :view do
	before(:each) do
		render :template => "contacts/thanks", :layout => "layouts/application"
	end
	
	it "must display the correct breadcrumb" do
		expect(rendered).to have_content("You are here: HomeGet In Touch")
	end
end
