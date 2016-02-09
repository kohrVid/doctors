FactoryGirl.define do
	factory :appointment do
		association :doctor, factory: :doctor
		association :patient, factory: :patient
		start_time Time.new(2015, 12, 03, 11, 05, 00)
		end_time Time.new(2015, 12, 03, 11, 05, 00)
		cancelled false
	end

end
