require 'rails_helper'

RSpec.describe User, type: :model do
	before do 
		@valid_patient = {
			first_name: "Tobey",
			middle_name: "Snake-River",
			last_name: "Torres",
			phone: "0123456789",
			address: FactoryGirl.create(:address),
			username: "ttorres",
			email: "ttorres@snakeriverconspiracy.com",
			password: "TheSmiths",
			password_confirmation: "TheSmiths",
			approved: true,
			patient: true,
			reception: false,
			doctor: false,
			admin: false
		}
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
