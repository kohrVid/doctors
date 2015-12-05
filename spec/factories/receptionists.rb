FactoryGirl.define do
  factory :receptionist do
	title "Mr"
	first_name "Gary"
	middle_name "T"
	last_name "Hennchman"
	dob "1975-06-21"
	phone "0123456789"
	address {create(:address)}
	username "ghenchman"
	email "ghenchman@hospital.com"
	password "LoTRfrodo"
	password_confirmation "LoTRfrodo"
	approved true
	patient false
	receptionist true
	doctor false
	admin false
  end

end
