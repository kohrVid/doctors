require 'rails_helper'

RSpec.describe User, type: :model do
	before do 
		@valid_user = {
			title: "Ms",
			first_name: "Tobey",
			middle_name: "Snake-River",
			last_name: "Torres",
			dob:"1973-11-15",
			phone: "0123456789",
			address: FactoryGirl.create(:address),
			username: "ttorres",
			email: "ttorres@snakeriverconspiracy.com",
			password: "TheSmiths",
			password_confirmation: "TheSmiths",
			approved: true,
			patient: true,
			receptionist: false,
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
			User.create(@valid_user)
		}).to change(User, :count).by(1)
	end

	context "Title" do
		it "must be present" do
			u = @valid_user
			u[:title] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		it "must produce an error if no title is given" do
			u = User.new
			expect(u.errors[:title]).to_not be_nil
		end

		it "must be no more than 5 characters long" do
			u = @valid_user
			u[:title] = "t"*6
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end
	end

	context "First Name" do
		it "must be present" do
			u = @valid_user
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
			u = @valid_user
			u[:first_name] = "t"*51
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end
	end

	context "Middle Name" do
		it "must be no more than 75 characters long" do
			u = @valid_user
			u[:middle_name] = "t"*76
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end

		it "must be optional" do
			u = @valid_user
			u[:middle_name] = ""
			expect(lambda{
				User.create(u)
			}).to change(User, :count).by(1)
		end

	end

	context "Last Name" do
		it "must be present" do
			u = @valid_user
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
			u = @valid_user
			u[:last_name] = "t"*51
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end
	end
	
	context "Date of Birth" do
		it "must be present" do
			u = @valid_user
			u[:dob] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		it "must produce an error if no date is given" do
			u = User.new
			expect(u.errors[:dob]).to_not be_nil
		end
	end

	context "Username" do
		it "must be present" do
			u = @valid_user
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
			u = @valid_user
			u[:username] = "t"*16
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)

		end

		it "must be unique" do
			u = FactoryGirl.create(:user)
			v = @valid_user 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "jslater@snakeriverconspiracy.com")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end

		it "must be case-insensitive" do
			u = FactoryGirl.create(:user)
			v = @valid_user 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "jslater@snakeriverconspiracy.com", username: "TTORRES")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end

		it "can't be in list of banned usernames" do
			banned_usernames = %w(admin moderator webmaster webadmin administrator adm)
			banned_usernames.each do |name|
				u = @valid_user
				u[:username] = name
				expect(lambda{
					User.create(u)
				}).to_not change(User, :count)
			end
		end
	end


	context "Email" do
		it "can be optional" do
			u = @valid_user
			u[:email] = ""
			expect(lambda{
				User.create(u)
			}).to change(User, :count).by(1)
		end

			
		it "must be no more than 255 characters long" do
			u = @valid_user
			u[:email] = "t"*231+"@snakeriverconspiracy.com"
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end
		
		valid_email_address = %w(user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com)
		valid_email_address.each do |email_address|
			it "must be a valid email address" do
				u = @valid_user
				u[:email] = email_address
				expect(lambda{
					User.create(u)
				}).to change(User, :count).by(1)
			end
		end

		invalid_email_address = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com)
		invalid_email_address.each do |email_address|
			it "must not be an invalid email address" do
				u = @valid_user
				u[:email] = email_address
				expect(lambda{
					User.create(u)
				}).to_not change(User, :count)
			end
		end

		it "must be unique" do
			u = FactoryGirl.create(:user)
			v = @valid_user 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "ttorres@snakeriverconspiracy.com", username: "jslater")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end
		
		it "must be case-insensitive" do
			u = FactoryGirl.create(:user)
			v = @valid_user 
			v.merge!(first_name: "Jason", middle_name: "", last_name: "Slater", email: "TTORRES@SNAKERIVERCONSPIRACY.COM", username: "jslater")
			expect(lambda{
				User.create(v)
			}).to_not change(User, :count)
		end
	end

	context "Password" do
		it "must be present" do
			u = @valid_user
			u[:password] = ""
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end

		it "must produce an error if no password is given" do
			u = User.new
			expect(u.errors[:password]).to_not be_nil
		end

		it "must be at least six characters long" do
			u = FactoryGirl.build(:user)
			u.password = "five5"
			u.password_confirmation = "five5"
			expect(u).to_not be_valid
		end
		
		it "must have a password confirmation that matches the password" do
			u = FactoryGirl.build(:user)
			u.password = "TrainsNsewing"
			u.password_confirmation = "Machines"
			expect(u).to_not be_valid
		end

	end

	context "Phone" do
		it "must be present" do
			u = @valid_user
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
			u = @valid_user
			u[:address] = nil
			expect(lambda{
				User.create(u)
			}).to_not change(User, :count)
		end

	end
	
	context "Appointments" do
		it "can exist" do
			expect(User.new).to respond_to(:appointments)
		end
	end

end
