require 'rails_helper'
require 'cancan/matchers'

RSpec.describe UsersController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:patient2) { FactoryGirl.create(:user) }
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
		
		it "should be unable to edit users" do
			expect { get :edit, id: patient.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete users" do
			expect { delete :destroy, id: patient.id }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Patient" do
		it "must be able to see its attributes" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, User.find(patient.id))
		end
		
		it "must be able edit itself" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:update, User.find(patient.id))
		end
		
		it "must be unable delete itself" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:destroy, User.find(patient.id))
		end
	end

	context "Doctor" do
		let(:doctor2) { FactoryGirl.create(:doctor, username: "drgirlfriend", email: "drgirlfriend@thehospital.com") }

		it "must be able to see its attributes" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, User.find(doctor.id))
		end

		it "must be able edit itself" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, User.find(doctor.id))
		end
		
		it "must be unable delete itself" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to_not be_able_to(:destroy, User.find(doctor.id))
		end
		
		it "must not be able to lockout other doctors" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to_not be_able_to(:update, User.find(doctor2.id))
		end

		it "must not be able to delete user accounts" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to_not be_able_to(:destroy, User.find(patient2.id))
		end
	end

	context "Receptionist" do	
		let(:receptionist2) { FactoryGirl.create(:receptionist, username: "number24", email: "number24@thehospital.com") }
		it "must be able to see its attributes" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:read, User.find(receptionist.id))
		end

		it "must be able edit itself" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:update, User.find(receptionist.id))
		end
		
		it "must be unable delete itself" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, User.find(receptionist.id))
		end
		
		it "must not be able to lockout other receptionists" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:update, User.find(receptionist2.id))
		end

		it "must not be able to delete user accounts" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, User.find(patient2.id))
		end

	end

	context "Admin" do
		let(:admin2) { FactoryGirl.create(:admin, username: "jurbaniak", email: "jurbaniak@thehospital.com") }
		it "must be able to see its attributes" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:read, User.find(admin.id))
		end

		it "must be able edit itself" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:update, User.find(admin.id))
		end
		
		it "must be unable delete itself" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to_not be_able_to(:destroy, User.find(admin.id))
		end
		
		it "must be able to create new users" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:create, User.new(@valid_user))
		end

		it "must be able to approve new users" do
			allow(controller).to receive(:current_user).and_return(admin)
			get "edit", id: patient.id
			expect(response).to render_template("edit")
			##################################
		end
		
		it "must be able to delete user accounts" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, User.new)
		end

		it "should be able to delete other admin accounts" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, User.find(admin2.id))
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
