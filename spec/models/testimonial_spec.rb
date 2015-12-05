require 'rails_helper'

RSpec.describe Testimonial, type: :model do

	before do
		@valid_testimonial = {
			author: "Dean V.",
			date: "2015-12-04",
			body: "Dr. Hammer was really quick to diagnose my testicular torsion and got it fixed in a jiffy. Thanks a million!"
		}
	end

	it "must have required fields or be invalid" do
		t = Testimonial.new
		expect(t).to_not be_valid
	end

	it "must create a new testimonial with valid attributes" do
		expect(lambda{
			Testimonial.create(@valid_testimonial)
		}).to change(Testimonial, :count).by(1)
	end
	context "Author" do
		it "must be present" do
			t = @valid_testimonial
			t[:author] = ""
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end
		
		it "must produce an error if no name is given" do
			t = Testimonial.new
			expect(t.errors[:author]).to_not be_nil
		end

		it "must be at least 2 characters long" do
			t = @valid_testimonial
			t[:author] = "i"
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end

		it "must be no longer than 50 characters" do
			t = @valid_testimonial
			t[:author] = "i"*51
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end
	end

	context "body" do
		it "must be present" do
			t = @valid_testimonial
			t[:body] = ""
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end
		
		it "must produce an error if the body of the testimonial is missing" do
			t = Testimonial.new
			expect(t.errors[:body]).to_not be_nil
		end

		it "must be at least 3 characters long" do
			t = @valid_testimonial
			t[:body] = "bb"
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end

		it "must be no longer than 1500 characters" do
			t = @valid_testimonial
			t[:body] = "b"*1501
			expect(lambda{
				Testimonial.create(t)
			}).to_not change(Testimonial, :count)
		end
	end

end
