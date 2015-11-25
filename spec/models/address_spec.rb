require 'rails_helper'

RSpec.describe Address, type: :model do
	before do
		@valid_address = {
		    street: "33 Vulcan",
		    address_line2: "Snake River",
		    city: "San Francisco",
		    county: "California",
		    post_code: "CA9 O21"
		}
	end

	it "must have required fields or be invalid" do
		a = Address.new
		expect(a).to_not be_valid
	end

	it "must create a new address with valid attributes" do
		expect(lambda{
			Address.create(@valid_address)
		}).to change(Address, :count).by(1)
	end


	context "Street" do
		it "must be present" do
			a = @valid_address
			a[:street] = ""
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
		
		it "must produce an error if no street is given" do
			a = Address.new
			expect(a.errors[:street]).to_not be_nil
		end

		it "must be no more than 75 characters long" do
			a = @valid_address
			a[:street] = "t"*76
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)

		end
	end
	
	context "Address Line 2" do
		it "must be no more than 75 characters long" do
			a = @valid_address
			a[:address_line2] = "t"*76
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
		it "must be optional" do
			a = @valid_address
			a[:address_line2] = ""
			expect(lambda{
				Address.create(a)
			}).to change(Address, :count).by(1)
		end

	end

	context "City" do
		it "must be present" do
			a = @valid_address
			a[:city] = ""
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
		
		it "must produce an error if no city is given" do
			a = Address.new
			expect(a.errors[:city]).to_not be_nil
		end

		it "must be no more than 50 characters long" do
			a = @valid_address
			a[:city] = "t"*51
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)

		end
	end
	context "County" do
		it "must be present" do
			a = @valid_address
			a[:county] = ""
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
		
		it "must produce an error if no county is given" do
			a = Address.new
			expect(a.errors[:county]).to_not be_nil
		end

		it "must be no more than 75 characters long" do
			a = @valid_address
			a[:county] = "t"*76
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)

		end
	end

	context "Post Code" do
		it "must be present" do
			a = @valid_address
			a[:post_code] = ""
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
		
		it "must produce an error if no post code is given" do
			a = Address.new
			expect(a.errors[:post_code]).to_not be_nil
		end

		it "must be no more than 7 characters long" do
			a = @valid_address
			a[:post_code] = "t"*8
			expect(lambda{
				Address.create(a)
			}).to_not change(Address, :count)
		end
	end
end
