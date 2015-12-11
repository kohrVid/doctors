require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:admin) { FactoryGirl.create(:admin) }
	
	context "Non-Users" do
		it "should be able to view all doctors" do
			expect(get :index).to be_success
		end
		
		it "should be able to view individual doctors" do
			expect(get :show, id: doctor.id).to be_success 
		end
		
		it "should not successfulLy get new" do
			expect{ get :new }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to edit doctors" do
			expect { get :edit, id: doctor.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete doctors" do
			expect { delete :destroy, id: doctor.id }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Patient" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(patient)
		end
		
		it "should be able to view all doctors" do
			ability = Ability.new(patient)
			expect(get :index).to be_success
		end
		
		it "should be able to view individual doctors" do
			ability = Ability.new(patient)
			expect(get :show, id: doctor.id).to be_success 
		end
		
		it "should not successfulLy get new" do
			ability = Ability.new(patient)
			expect{get :new }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to edit doctors" do
			ability = Ability.new(patient)
			expect{ get :edit, id: doctor.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete doctors" do
			ability = Ability.new(patient)
			expect { delete :destroy, id: doctor.id }.to raise_error(CanCan::AccessDenied)
		end
	end
	
	context "Receptionist" do	
		before(:each) do
			allow(controller).to receive(:current_user).and_return(receptionist)
		end
		
		it "must be unable to create new doctors" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:new, Doctor.new)
		end
		
		it "must be unable to update doctors" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:update, Doctor.new)
		end
		
		it "must be unable to delete doctors" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Doctor.find(doctor.id))
		end
		
		it "must not be able to delete doctor accounts" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Doctor.find(doctor.id))
		end
	end

	context "Doctor" do
		let(:doctor2) { FactoryGirl.create(:doctor, username: "drgirlfriend", email: "drgirlfriend@hospital.com") }
		before(:each) do
			allow(controller).to receive(:current_user).and_return(doctor)
		end
		
		it "should be able to view all doctors" do
			expect(get :index).to be_success
		end

		it "should not successfully get new" do
			expect{ get :new }.to raise_error(CanCan::AccessDenied)
		end

		it "must be able to see its attributes" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, Doctor.find(doctor.id))
		end
		
		it "must be unable to edit other doctors" do
			ability = Ability.new(doctor)
			expect(ability).to_not be_able_to(:update, Doctor.find(doctor2.id))
		end
		
		it "must be able to edit its attributes" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, Doctor.find(doctor.id))
		end
		
		it "must be able to see other non-medical staff's attributes" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, Doctor.find(doctor2.id))
		end
	end

	context "Admin" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(admin)
		end
		
		it "must be able to create new doctors" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:new, Doctor.new)
		end

		it "must be able to update doctors" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:update, Doctor.new)
		end
		
		it "must be able to delete doctor accounts" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, Doctor.find(doctor.id))
		end
	end
end
