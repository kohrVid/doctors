require 'rails_helper'

RSpec.describe User, type: :model do
	before do 
		@valid_patient = {
			first_name: "Tobey",
			middle_name: "Snake-River",
			last_name: "Torres",
			phone: "0123456789",
			address: @valid_address,
			username: "ttorres",
			email: "ttorres@snakeriverconspiracy.com",
			password: "TheSmiths",
			password_confirmation: "TheSmiths",
			patient: true,
			doctor: false,
			admin: false
		}
	end
	it "must have required fields or be invalid" do
		u = User.new
		expect(u).to_not be_valid
	end

	it "must create a new user with valid attributes" do
		expect(lambda{
			User.create(@valid_patient)
		}).to change(User, :count).by(1)
	end

	context "First Name" do
		it "must be present" do
			u = @valid_patient
			u[:first_name] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		it "must produce an error if no name is given" do
			u = User.new
			expect(u.errors[:first_name]).to_not be_nil
		end

		it "must be no more than 50 characters long" do
			u = @valid_patient
			u[:first_name] = "t"*51
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end
	end

	context "Middle Name" do
		it "must be no more than 75 characters long" do
			u = @valid_patient
			u[:middle_name] = "t"*76
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
	end

	context "Last Name" do
		it "must be present" do
			u = @valid_patient
			u[:last_name] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		it "must produce an error if no name is given" do
			u = User.new
			expect(u.errors[:last_name]).to_not be_nil
		end

		it "must be no more than 50 characters long" do
			u = @valid_patient
			u[:last_name] = "t"*51
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end
	end

	context "Username" do
		it "must be present" do
			u = @valid_patient
			u[:username] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		it "must produce an error if no username is given" do
			u = User.new
			expect(u.errors[:username]).to_not be_nil
		end

		it "must be no more than 15 characters long" do
			u = @valid_patient
			u[:username] = "t"*16
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end

		it "must be unique" do
			u = FactoryGirl.create(:user)
			v = @valid_patient 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "jslater@snakeriverconspiracy.com")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end

		it "must be case-insensitive" do
			u = FactoryGirl.create(:user)
			v = @valid_patient 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "jslater@snakeriverconspiracy.com", username: "TTORRES")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end
	end


	context "Email" do
		it "can be optional" do
			u = @valid_patient
			u[:email] = ""
			expect(lambda{
				User.create(u)
			}).to change(User, :count).by(1)
		end

			
		it "must be no more than 255 characters long" do
			u = @valid_patient
			u[:email] = "t"*231+"@snakeriverconspiracy.com"
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
					
		it "must be a valid email address" do
			valid_email_address = %w[user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com]
			valid_email_address.each do |email_address|
				u = @valid_patient
				u[:email] = email_address
				expect(lambda{
					User.create(u)
				}).to change(User, :count).by(1)
			end
		end

		it "must not be an invalid email address" do
			invalid_email_address = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com]
			invalid_email_address.each do |email_address|
				u = @valid_patient
				u[:email] = email_address
				expect(lambda{
					User.create(u)
				}).to_not change(User, :count)
			end
		end

		it "must be unique" do
			u = FactoryGirl.create(:user)
			v = @valid_patient 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "ttorres@snakeriverconspiracy.com", username: "jslater")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end
		
		it "must be case-insensitive" do
			u = FactoryGirl.create(:user)
			v = @valid_patient 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "TTORRES@SNAKERIVERCONSPIRACY.COM", username: "jslater")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end
	end

	context "Password" do
	end

	context "Phone" do
		it "must be present" do
			u = @valid_patient
			u[:phone] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end

		it "must produce an error if no phone number is given" do
			u = User.new
			expect(u.errors[:phone]).to_not be_nil
		end
	end

	context "Address" do
		it "must be present" do
			u = @valid_patient
			u[:address] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end

	end

	context "Patient" do
		it "must be unable to approve itself"
		it "must be unable to approve other users"
	end

	context "Doctor" do
		it "must be able to approve new users"
		it "must be able to edit pages"
		it "must be able to lock patient accounts"
		it "must not be able to lockout other doctors"
		it "must not be able to delete user accounts"
	end

	context "Admin" do
		it "must be able to approve new users"
		it "must be able to delete doctors"
	end
	context "Associations" do

	end

end
