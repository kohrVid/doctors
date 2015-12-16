require 'rails_helper'

RSpec.describe "testimonials/index.html.erb", type: :view do
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	context "attributes" do	
		before(:each) do
			assign(:testimonial, testimonial)
			@testimonials = Testimonial.all
			@current_user = FactoryGirl.create(:admin)
			render :template => "testimonials/index", :layout => "layouts/application"
		end
		
		it "must display the full title of page" do
			expect(rendered).to have_title("The Doctor's | Testimonials")
		end
		
		it "has a Date" do
			expect(rendered).to have_content(testimonial.date.strftime("%v"))
		end

		it "has a Body" do
			expect(rendered).to have_content(testimonial.body)
		end
		
		it "has an Author" do
			expect(rendered).to have_content(testimonial.author)
		end
		
		it "has a show button" do
			expect(rendered).to have_link("Show", href: testimonial_path(testimonial))
		end

		it "has an edit button" do
			expect(rendered).to have_link("Edit", href: edit_testimonial_path(testimonial))
		end

		it "has a destroy button" do
			expect(rendered).to have_link("Destroy")
		end

		it "has an Add Testimonial button" do
			expect(rendered).to have_link("Add Testimonial", href: new_testimonial_path)
		end
	end
end