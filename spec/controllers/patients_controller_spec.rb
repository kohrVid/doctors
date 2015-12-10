require 'rails_helper'
require 'cancan/matchers'

RSpec.describe PatientsController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:admin) { FactoryGirl.create(:admin) }
	
	context "Non-Users" do
		it "should be unable to view all patients" do
			expect { get :index }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to view patients" do
			expect { get :show, id: patient.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should successfulLy get new" do
			expect(get :new).to be_success
		end
		
		it "should render the 'new' template" do
			expect(get :new).to render_template("new")
		end
		
		it "should be unable to edit patients" do
			expect { get :edit, id: patient.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete patients" do
			expect { delete :destroy, id: patient.id }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Patient" do
		let(:patient2) { FactoryGirl.create(:user) }
		before(:each) do
			allow(controller).to receive(:current_user).and_return(patient)
		end
		
		it "should be unable to view all users" do
			expect { get :index }.to raise_error(CanCan::AccessDenied)
		end

		it "should successfulLy get new" do
			expect(get :new).to be_success
		end

		it "should render the 'new' template" do
			expect(get :new).to render_template("new")
		end

		it "must be able to see its attributes" do
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Patient.find(patient.id))
		end
		
		it "must be unable to edit other users" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:update, Patient.find(patient2.id))
		end
		
		it "must be able to edit its attributes" do
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:update, Patient.find(patient.id))
		end
		
		it "must be unable to see other non-medical staff's attributes" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:read, Patient.find(patient2.id))
		end
	end

	context "Receptionist" do	
		before(:each) do
			allow(controller).to receive(:current_user).and_return(receptionist)
		end
		
		it "must be able to create new patients" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:new, Patient.new)
		end
		
		it "must be able to update patients" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:update, Patient.new)
		end
		
		it "must be unable to delete patients" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Patient.find(patient.id))
		end
		
		it "must not be able to delete patient accounts" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Patient.find(patient.id))
		end

		it "must be able to reset patient passwords"
	end

	context "Doctor" do
		let(:doctor2) { FactoryGirl.build(:doctor, username: "drgirlfriend", email: "drgirlfriend") }
		before(:each) do
			allow(controller).to receive(:current_user).and_return(doctor)
		end
		
		it "must be able to update patients" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, Patient.new)
		end
		
		it "must be unable to delete patients" do
			ability = Ability.new(doctor)
			expect(ability).to_not be_able_to(:destroy, Patient.find(patient.id))
		end
	end

	context "Admin" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(admin)
		end
		
		it "must be able to create new patients" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:new, Patient.new)
		end

		it "must be able to update patients" do
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:update, Patient.new)
		end
		
		it "must be able to delete patient accounts" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, Patient.find(patient.id))
		end
=begin
		it "should not allow the admin attribute to be edited via the web" do
			log_in_as(@other_user)
			assert_not @other_user.admin?
			patch :update, id: @other_user, user: { password: "password",
								 password_confirmation: "password",
								 admin: true
			}
			assert_not @other_user.reload.admin?  
		end
=end
	end

end
