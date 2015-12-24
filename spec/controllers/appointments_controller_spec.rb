require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:admin) { FactoryGirl.create(:admin) }
	let(:appointment) { FactoryGirl.create(:appointment, doctor_id: doctor.id, patient_id: patient.id) }

	context "Non-Users" do
		it "should not be able to view all appointments" do
			expect{ get :index }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be able to view individual appointment" do
			expect{ get :show, id: appointment.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should not successfulLy get new" do
			expect{ get :new }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to edit appointment" do
			expect{ get :edit, id: appointment.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete appointment" do
			expect{ delete :destroy, id: appointment.id }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Patient" do
		let(:patient2) { FactoryGirl.create(:user) }
		let(:appointment2) { FactoryGirl.create(:appointment, doctor_id: doctor.id, patient_id: patient2.id, start_time: Time.new(2015, 12, 05, 11, 05, 00), end_time: Time.new(2015, 12, 05, 11, 05, 00)) }
		before(:each) do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
		end

		it "should be able to view index" do
			expect(get :index).to be_success
		end
		
		it "should be able to view their own individual appointments" do
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Appointment.find(appointment.id)) 
		end

		it "should not be able to view another user's appointments" do
			expect{ get :show, id: appointment2.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should successfulLy get new" do
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:create, Appointment.new) 
		end
		
		it "should be able to edit appointments" do
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Appointment.find(appointment.id)) 
		end
		
		it "should be unable to delete appointments" do
			expect{ delete :destroy, id: appointment.id }.to raise_error(CanCan::AccessDenied)
		end
	end
	
	context "Receptionist" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(receptionist)
		end

		it "should be able to view index" do
			expect(get :index).to be_success
		end
		
		it "should be able to view individual appointments" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:read, Appointment.find(appointment.id)) 
		end

		it "should successfully get new" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:new, Appointment.new) 
		end
		
		it "should be able to edit appointments" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:update, Appointment.find(appointment.id)) 
		end
		
		it "should be unable to delete appointments" do
			expect{ delete :destroy, id: appointment.id }.to raise_error(CanCan::AccessDenied)
		end
	end
	
	context "Doctor" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(doctor)
		end

		it "should be able to view index" do
			expect(get :index).to be_success
		end
		
		it "should be able to view individual appointments" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, Appointment.find(appointment.id))
		end

		it "should successfulLy get new" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:create, Appointment.new)
		end
		
		it "should be able to edit appointments" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, Appointment.find(appointment.id))
		end
		
		it "should be able to delete appointments" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:destroy, Appointment.find(appointment.id))
		end
	end
	
	context "Admin" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(admin)
		end

		it "should be able to view index" do
			expect(get :index).to be_success
		end
		
		it "should be able to view individual appointments" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:read, Appointment.find(appointment.id))
		end

		it "should successfulLy get new" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:create, Appointment.new)
		end
		
		it "should be able to edit appointments" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:update, Appointment.find(appointment.id))
		end
		
		it "should be able to delete appointments" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, Appointment.find(appointment.id))
		end
	end

end
