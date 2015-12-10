require 'rails_helper'

RSpec.describe Patient, type: :model do
	before do 
		@valid_patient = {
			title: "Mr",
			first_name: "Jason",
			middle_name: "",
			last_name: "Slater",
			dob: "1969-04-06",
			phone: "0123456789",
			address: FactoryGirl.create(:address),
			username: "jslater",
			email: "jslater@snakeriverconspiracy.com",
			password: "RobertSmith",
			password_confirmation: "RobertSmith",
			approved: true,
			patient: true,
			receptionist: false,
			doctor: false,
			admin: false
		}
	end

	context "NHS number" do
		it "must be present" do
			p = @valid_patient
			p[:nhs_number] = ""
			expect(lambda{
				Patient.create(p)
			}).to_not change(Patient, :count)
		end
		
		it "must produce an error if no number is given" do
			p = Patient.new
			expect(p.errors[:nhs_number]).to_not be_nil
		end

		it "must be exactly 10 characters long" do
			p = @valid_patient
			p[:nhs_number] = "01234567890"
			q = p
			q[:nhs_number] = "123456789"
			expect(lambda{
				Patient.create(p)
			}).to_not change(Patient, :count)
			expect(lambda{
				Patient.create(q)
			}).to_not change(Patient, :count)
		end
	end

	context "Gender" do
		it "must be present" do
			p = @valid_patient
			p[:gender] = ""
			expect(lambda{
				Patient.create(p)
			}).to_not change(Patient, :count)
		end
		
		it "must produce an error if no gender is given" do
			p = Patient.new
			expect(p.errors[:gender]).to_not be_nil
		end

		it "must be no more than 5 characters long" do
			p = @valid_patient
			p[:gender] = "t"*6
			expect(lambda{
				Patient.create(p)
			}).to_not change(Patient, :count)
		end
	end
	
	context "Preferred Doctor" do
		it "can exist" do
			expect(Patient.new).to respond_to(:preferred_doctor)
		end

		it "must be a type of user" do
			u = FactoryGirl.build(:patient)
			expect(u.preferred_doctor).to_not be_nil
			expect(u.preferred_doctor).to be_kind_of(User)
		end
	end


	context "Appointments" do
		it "can exist" do
			expect(User.new).to respond_to(:appointments)
		end
	end
end
