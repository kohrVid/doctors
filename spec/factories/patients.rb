FactoryGirl.define do
  factory :patient do
	first_name "Jason"
	middle_name ""
	last_name "Slater"
	phone "0123456789"
	address {create(:address)}
	preferred_doctor {build(:doctor)}
	username "jslater"
	email "jslater@snakeriverconspiracy.com"
	password "RobertSmith"
	password_confirmation "RobertSmith"
	approved true
	patient true
	reception false
	doctor 	false
	admin false

  end
end
