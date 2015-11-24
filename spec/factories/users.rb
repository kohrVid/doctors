FactoryGirl.define do
  factory :user do
	first_name "Tobey"
	middle_name "Snake-River"
	last_name "Torres"
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
