FactoryGirl.define do
  factory :admin do
	title "Mr"
	first_name "Jackson"
	middle_name "CMcC"
	last_name "Publick"
	dob "1971-09-14"
	phone "0123456789"
	address {create(:address)}
	username "jpublick"
	email "jpublick@hospital.com"
	password "yesRawes0me"
	password_confirmation "yesRawes0me"
	approved true
	patient false
	receptionist false
	doctor false
	admin true
  end

end
