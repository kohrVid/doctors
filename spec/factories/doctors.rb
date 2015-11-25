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
	patient false
	reception false
	doctor true
	admin false
  end

end
