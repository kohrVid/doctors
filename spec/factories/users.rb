FactoryGirl.define do
  factory :user do
	title "Ms"
	first_name "Tobey"
	middle_name "Snake-River"
	last_name "Torres"
	dob "1973-11-15"
	phone "0123456789"
	address {create(:address)}
	username "ttorres"
	email "ttorres@snakeriverconspiracy.com"
	password "TheSmiths"
	password_confirmation "TheSmiths"
	approved true
	patient true
	reception false
	doctor 	false
	admin false

  end
end
