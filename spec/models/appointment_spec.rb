require 'rails_helper'

RSpec.describe Appointment, type: :model do
	before do
		@valid_appointment = {
			doctor: FactoryGirl.create(:doctor),
			patient: FactoryGirl.create(:patient),
			start_time: Time.new(2015, 12, 03, 11, 05, 00),
			end_time: Time.new(2015, 12, 03, 11, 25, 00),
			cancelled: false
		}
	end

	it "must have required fields or be invalid" do
		a = Appointment.new
		expect(a).to_not be_valid
	end

	it "must create a new appointment with valid attributes" do
		expect(lambda{
			Appointment.create(@valid_appointment)
		}).to change(Appointment, :count).by(1)
	end



	context "Associations" do
		it "belongs to doctors" do
			expect(Appointment.new).to respond_to(:doctor)
		end

		it "belongs to patients" do
			expect(Appointment.new).to respond_to(:patient)
		end

		it "belongs to a type of user" do
			a = Appointment.create(@valid_appointment)
			expect(a.doctor).to_not be_nil
			expect(a.doctor).to be_kind_of(User)
			expect(a.patient).to_not be_nil
			expect(a.patient).to be_kind_of(User)
		end
	end

	context "Date" do
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

	context "Event" do
		context "Duplicate Start and End Times" do
			it "cannot create appointments with the same start and end times for a doctor" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient] = FactoryGirl.build(:user)
				second_appointment[:doctor].id = first_appointment[:doctor].id
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 05, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to_not change(Appointment, :count)
			end
			
			it "cannot create appointments with the same start and end time for a patient" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient].id = first_appointment[:patient].id
				second_appointment[:doctor] = FactoryGirl.create(:doctor, username: "drgirlfriend1", 
							       email: "drgirlfriend1@thehospital.com")
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 05, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 25, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to_not change(Appointment, :count)
			end
		end

		context "Overlap" do
			it "cannot create overlapping appointments for the same doctor" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient] = FactoryGirl.build(:user)
				second_appointment[:doctor].id = first_appointment[:doctor].id
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 05, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to_not change(Appointment, :count)
			end
			
			it "cannot create overlapping appointments for the same patient" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient].id = first_appointment[:patient].id
				second_appointment[:doctor] = FactoryGirl.create(:doctor, username: "drgirlfriend1", 
							       email: "drgirlfriend1@thehospital.com")
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 00, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to_not change(Appointment, :count)
			end
		end
		
		context "Non-Overlapping" do 
			it "can create non-overlapping appointments for the same doctor" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient] = FactoryGirl.build(:user)
				second_appointment[:doctor].id = first_appointment[:doctor].id
				second_appointment[:start_time] = Time.new(2015, 12, 04, 11, 00, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 04, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to change(Appointment, :count).by(1)
			end
			
			it "can create non-overlapping appointments for the same patient" do
				first_appointment = @valid_appointment
				expect(lambda{
					Appointment.create(first_appointment)
				}).to change(Appointment, :count).by(1)
				second_appointment = @valid_appointment
				second_appointment[:patient].id = first_appointment[:patient].id
				second_appointment[:doctor] = FactoryGirl.create(:doctor, username: "drgirlfriend1", 
							       email: "drgirlfriend1@thehospital.com")
				second_appointment[:start_time] = Time.new(2015, 12, 04, 11, 00, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 04, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to change(Appointment, :count).by(1)
			end
		end

		context "Cancellations" do
			it "can create appointments with the same start and end times for a doctor if a previous appointment has been cancelled" do
				first_appointment = @valid_appointment
				cancelled_appointment = Appointment.create(first_appointment)
				cancelled_appointment.update_attributes(cancelled: true)
				second_appointment = @valid_appointment
				second_appointment[:patient] = FactoryGirl.build(:user)
				second_appointment[:doctor].id = first_appointment[:doctor].id
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 05, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 20, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to change(Appointment, :count).by(1)
			end
			
			it "can create appointments with the same start and end time for a patient if a previous appointment has been cancelled" do
				first_appointment = @valid_appointment
				cancelled_appointment = Appointment.create(first_appointment)
				cancelled_appointment.update_attributes(cancelled: true)
				second_appointment = @valid_appointment
				second_appointment[:patient].id = first_appointment[:patient].id
				second_appointment[:doctor] = FactoryGirl.create(:doctor, username: "drgirlfriend1", 
							       email: "drgirlfriend1@thehospital.com")
				second_appointment[:start_time] = Time.new(2015, 12, 03, 11, 05, 00)
				second_appointment[:end_time] = Time.new(2015, 12, 03, 11, 25, 00)
				expect(lambda{
					Appointment.create(second_appointment)
				}).to change(Appointment, :count).by(1)
			end

		end
	end
end
