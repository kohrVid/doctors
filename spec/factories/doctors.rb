FactoryGirl.define do
  factory :doctor do
	first_name "Eric"
	middle_name "A"
	last_name "Hammer"
	phone "0123456789"
	address {create(:address)}
	username "drhammer"
	email "drhammer@hospital.com"
	password "TheCure"
	password_confirmation "TheCure"
	approved true
	patient true
	reception false
	doctor false
	admin false
  end

end
