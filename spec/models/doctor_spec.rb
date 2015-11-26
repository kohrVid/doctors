require 'rails_helper'

RSpec.describe Doctor, type: :model do
	before do 
		@valid_doctor = {
			title: "Dr",
			first_name: "Eric",
			middle_name: "A",
			last_name: "Hammer",
			dob: "1967-02-02",
			phone: "0123456789",
			address: FactoryGirl.create(:address),
			biography: "Eric is a doctor at The Doctor's Surgery. He's awesome and knows the Sovereign",
			username: "drhammer",
			email: "drhammer@hospital.com",
			password: "TheCure",
			password_confirmation: "TheCure",
			approved: true,
			patient: false,
			reception: false,
			doctor: true,
			admin: false
		}
	end
	context "Biography" do
		it "must be present" do
			d = @valid_doctor
			d[:biography] = ""
			expect(lambda{
				Doctor.create(d)
			}).to_not change(Doctor, :count)
		end
		
		it "must produce an error if no biography is given" do
			d = Doctor.new
			expect(d.errors[:biography]).to_not be_nil
		end
	end
=begin
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
=end
	
end
