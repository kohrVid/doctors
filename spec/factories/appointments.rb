FactoryGirl.define do
	factory :appointment do
		association :doctor, factory: :doctor
		association :patient, factory: :user
		date "2015-12-03"
		start_time "2015-12-03 11:05:00"
		end_time "2015-12-03 11:25:00"
end

end
