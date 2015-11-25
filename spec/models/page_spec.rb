require 'rails_helper'

RSpec.describe Page, type: :model do
	before do
		@valid_page = {
			title: "Medical Info",
			description: "This valuable medical infor for NHS patients"
		}
	end

	it "must have required fields or be invalid" do
		p = Page.new
		expect(p).to_not be_valid
	end

	it "must create a new page with valid attributes" do
		expect(lambda{
			Page.create(@valid_page)
		}).to change(Page, :count).by(1)
	end

	context "Title" do
		it "must be present" do
			p = @valid_page
			p[:title] = ""
			expect(lambda{
				Page.create(p)
			}).to_not change(Page, :count)
		end
		
		it "must produce an error if no title is given" do
			p = Page.new
			expect(p.errors[:title]).to_not be_nil
		end

		it "must be at least three characters long" do
			p = @valid_page
			p[:title] = "t"*2
			expect(lambda{
				Page.create(p)
			}).to_not change(Page, :count)
		end
	end
	
	context "Description" do
		it "must be present" do
			p = @valid_page
			p[:description] = ""
			expect(lambda{
				Page.create(p)
			}).to_not change(Page, :count)
		end
		
		it "must produce an error if no description is given" do
			p = Page.new
			expect(p.errors[:description]).to_not be_nil
		end

		it "must be at least ten characters long" do
			p = @valid_page
			p[:description] = "t"*9
			expect(lambda{
				Page.create(p)
			}).to_not change(Page, :count)
		end
	end
end
