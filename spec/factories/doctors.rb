FactoryGirl.define do
  factory :doctor do
	title "Dr"
	first_name "Eric"
	middle_name "A"
	last_name "Hammer"
	dob "1967-02-02"
	phone "0123456789"
	address {create(:address)}
	biography "Eric is a doctor at The Doctor's Surgery. He's awesome and knows the Sovereign"
	username "drhammer"
	email "drhammer@hospital.com"
	password "TheCure"
	password_confirmation "TheCure"
	approved true
	patient false
	reception false
	doctor true
	admin false
  end

end
