FactoryGirl.define do
  factory :user do
	first_name "Tobey"
	middle_name "Snake-River"
	last_name "Torres"
	phone "0123456789"
	address "33 Vulcan, Snake River, San Francisco, CA 90210"
	username "ttorres"
	email "ttorres@snakeriverconspiracy.com"
	password "TheSmiths"
	password_confirmation "TheSmiths"
	patient true
	doctor false
	admin false

  end

end
