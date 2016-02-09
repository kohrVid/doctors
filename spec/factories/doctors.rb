FactoryGirl.define do
  factory :doctor do
	title "Dr"
	first_name "Eric"
	middle_name "A."
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
	receptionist false
	doctor true
	admin false
  end
=begin  
  factory :doctor2 do
	title "Dr"
	first_name "Mrs"
	middle_name "TheMonarch"
	last_name "Girlfriend"
	dob "1969-07-28"
	phone "0123456789"
	address {create(:address)}
	biography "She also works here and is an excellent driver. She also sings."
	username "drgirlfriend"
	email "drgirlfriend@hospital.com"
	password "DepecheMode"
	password_confirmation "DepecheMode"
	approved true
	patient false
	receptionist false
	doctor true
	admin false
  end
=end
end
