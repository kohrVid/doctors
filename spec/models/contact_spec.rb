require 'rails_helper'

RSpec.describe Contact, type: :model do
	before do
		@valid_contact = {
			name: "Tobey Torres",
			email: "ttorres@snakeriverconspiracy.com",
			message: "I have a suggestion: prescribe more vicodin!"
		}
	end
	
	context "Name" do
		it "must be present" do
			c = @valid_contact
			c[name] = ""
			expect(lambda{
				Contact.create(c)
			}).to_not change(Contact, :count)
		end

		it "must produce an error if no name if given" do
			c = Contact.new
			expect(c.errors[:name]).to_not be_nil
		end

		it "must be at least 2 characters long" do
			c = @valid_contact
			c[:name] = "c"
			expect(lambda{
				Contact.create(c)
			}).to_not change(Contact, :count)
		end

		it "must be no longer than 75 characters" do
			c = @valid_contact
			c[:name] = "c"*76
			expect(lambda{
				Contact.create(c)
			}).to_not change(Contact, :count)
		end
	end
	
	context "Email" do
		it "must be present" do
			c = @valid_contact
			c[:email] = ""
			expect(lambda{
				Contact.create(c)
			}).to_not change(Contact, :count)
		end

		it "must produce an error if no email if given" do
			c = Contact.new
			expect(c.errors[:email]).to_not be_nil
		end

		it "must be no longer than 255 characters" do
			c = @valid_contact
			c[:name] = "c"*231+"@snakeriverconspiracy.com"
			expect(lambda{
				Contact.create(c)
			}).to_not change(Contact, :count)
		end
		
		valid_email_address = %w(user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com)
		valid_email_address.each do |email_address|
			it "must be a valid email address" do
				c = @valid_contact
				c[:email] = email_address
				expect(lambda{
					Contact.create(c)
				}).to change(Contact, :count).by(1)
			end
		end

		invalid_email_address = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com)
		invalid_email_address.each do |email_address|
			it "must not be an invalid email address" do
				c = @valid_contact
				c[:email] = email_address
				expect(lambda{
					Contact.create(c)
				}).to_not change(Contact, :count)
			end
		end
	end

end
