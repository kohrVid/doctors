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
			receptionist: false,
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

		it "must be at least 10 characters long" do
			d = @valid_doctor
			d[:biography] = "b"*9
			expect(lambda{
				Doctor.create(d)
			}).to_not change(Doctor, :count)
		end
		
		it "must be no longer than 750 characters" do
			d = @valid_doctor
			d[:biography] = "b"*751
			expect(lambda{
				Doctor.create(d)
			}).to_not change(Doctor, :count)
		end
			
	end
	
end
