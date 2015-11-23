FactoryGirl.define do
  factory :user do
	first_name "Tobey"
	middle_name "Snake-River"
	last_name "Torres"
	phone "0123456789"
	username "ttorres"
	email "ttorres@snakeriverconspiracy.com"
	crypted_password "TheSmiths"
	patient true
	doctor false
	admin false

  end
end
