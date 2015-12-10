FactoryGirl.define do
  factory :patient do
	title "Mr"
	first_name "Jason"
	middle_name ""
	last_name "Slater"
	dob "1969-04-06"
	gender "M"
	nhs_number "1234567890"
	phone "0123456789"
	address {create(:address)}
	preferred_doctor {build(:doctor, first_name: "Mrs", middle_name: "The Monarch", last_name: "Girlfriend", dob: "1969-07-28", username: "drgirlfriend", email: "drgirlfriend@hospital.com", password:"DepecheMode", password_confirmation: "DepecheMode", biography: "She also works here and is an excellent driver. She also sings.")}
	username "jslater"
	email "jslater@snakeriverconspiracy.com"
	password "RobertSmith"
	password_confirmation "RobertSmith"
	approved true
	patient true
	receptionist false
	doctor 	false
	admin false

  end
end
