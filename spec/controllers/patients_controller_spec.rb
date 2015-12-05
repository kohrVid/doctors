require 'rails_helper'
require 'cancan/matchers'

RSpec.describe PatientsController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:admin) { FactoryGirl.create(:admin) }
	
	context "'GET' index" do
		it "should be successful" do
			expect(get :index).to be_success
		end

		it "should render the 'index' template" do
			expect(get :index).to render_template("index")
		end
	end

	context "'GET' new" do
		it "should be successful" do
			expect(get :new).to be_success
		end

		it "should render the 'new' template" do
			expect(get :new).to render_template("new")
		end
	end

	context "Non-Users" do
		it "should be unable to view patients" do
			expect { get :show, id: patient.id }.to raise_error(CanCan::AccessDenied)
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
		
		it "must be able to see its attributes" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Patient.find(patient.id))
		end
		
		it "must be unable to edit other users" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:update, Patient.find(patient2.id))
		end
		
		it "must be able to edit its attributes" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:update, Patient.find(patient.id))
		end
		
		it "must be unable to see other non-medical staff's attributes" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:read, Patient.find(patient2.id))
		end
	end

	context "Doctor" do
		let(:doctor2) { FactoryGirl.build(:doctor, username: "drgirlfriend", email: "drgirlfriend") }

		it "must be able to approve new patients" do
			allow(controller).to receive(:current_user).and_return(doctor)
			get "edit", id: patient.id
			expect(response).to render_template("edit")
			##################################
		end
		
		it "must be able to lock patient accounts" do
			allow(controller).to receive(:current_user).and_return(doctor)
			get "edit", id: patient.id
			expect(response).to render_template("edit")
			##################################
		end
		
	end

	context "Receptionist" do	
		it "must be able to create new patients" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:new, Patient.new)
		end

		it "must be able to approve new patients" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			get "edit", id: patient.id
			expect(response).to render_template("edit")
			##################################
		end
		
		it "must not be able to delete patient accounts" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Patient.find(patient.id))
		end

		it "must be able to reset patient passwords"
	end

	context "Admin" do
		it "must be able to create new patients" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:new, Patient.new)
		end

		it "must be able to approve new patient" do
			allow(controller).to receive(:current_user).and_return(admin)
			get "edit", id: patient.id
			expect(response).to render_template("edit")
			##################################
		end
		
		it "must be able to delete patient accounts" do
			allow(controller).to receive(:current_user).and_return(admin)
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
