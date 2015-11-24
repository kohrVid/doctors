require 'rails_helper'

RSpec.describe Appointment, type: :model do

	before do
		@valid_appointment = {
			doctor: FactoryGirl.build(:doctor),
			patient: FactoryGirl.build(:user),
			date: "2015-12-03",
			start_time: "2015-12-03 11:05:00",
			end_time: "2015-12-03 11:25:00"
		}
	end

	context "Associations" do
		it "belongs to doctors" do
			expect(Appointment.new).to respond_to(:doctor)
		end

		it "belongs to patients" do
			expect(Appointment.new).to respond_to(:patient)
		end

		it "belongs to a type of user" do
			a = FactoryGirl.create(:appointment)
			expect(a.doctor).to_not be_nil
			expect(a.doctor).to be_kind_of(User)
			expect(a.patient).to_not be_nil
			expect(a.patient).to be_kind_of(User)
		end
	end

	context "Date" do
		it "must have a date" do
			a = @valid_appointment
			a[:date] = ""
			expect(lambda{
				Appointment.create(a)
			}).to_not change(Appointment, :count)
		end
		
		it "must produce an error if no date is given" do
			a = Appointment.new
			expect(a.errors[:date]).to_not be_nil
		end

		it "must have an expected start time" do
			a = @valid_appointment
			a[:start_time] = ""
			expect(lambda{
				Appointment.create(a)
			}).to_not change(Appointment, :count)
		end
		
		it "must produce an error if no start time is given" do
			a = Appointment.new
			expect(a.errors[:start_time]).to_not be_nil
		end

		it "must have an expected end time" do
			a = @valid_appointment
			a[:end_time] = ""
			expect(lambda{
				Appointment.create(a)
			}).to_not change(Appointment, :count)
		end
		
		it "must produce an error if no end time is given" do
			a = Appointment.new
			expect(a.errors[:end_time]).to_not be_nil
		end
	end
end
