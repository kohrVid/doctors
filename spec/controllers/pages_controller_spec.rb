require 'rails_helper'

RSpec.describe PagesController, type: :controller do
	let(:page) { FactoryGirl.create(:page) }
	let(:patient) { FactoryGirl.create(:patient) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:admin) { FactoryGirl.create(:admin) }
	
	describe "'GET' index" do
		it "should be successful" do
			get "index"
			expect(response).to be_success
		end

		it "should render the index template" do
			get :index
			expect(response).to render_template("index")
		end
	end
	
	describe "'GET' show" do
		it "should be successful" do
			get "show"
			expect(response).to be_success
		end

		it "should render the show template" do
			get :show 
			expect(response).to render_template("show")
		end
	end

	describe "'GET' new" do
		it "should be unsuccessful if not authorised" do
			expect { get :new }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Doctors' permissions" do
		it "must allow Doctors to read pages" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, Page.find(page.id))
		end
		
		it "must allow Doctors to create pages" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:create, Page.new(@valid_page))
		end
		
		it "must allow Doctors to edit pages" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, Page.find(page.id))
		end
		
		it "must allow Doctors to delete pages" do
			allow(controller).to receive(:current_user).and_return(doctor)
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:destroy, Page.find(page.id))
		end
	end

	context "Admins' permissions" do
		it "must allow Admins to read pages" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:read, Page.find(page.id))
		end
		
		it "must allow Admins to create pages" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:create, Page.new(@valid_page))
		end
		
		it "must allow Admins to edit pages" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:update, Page.find(page.id))
		end
		
		it "must allow Admins to delete pages" do
			allow(controller).to receive(:current_user).and_return(admin)
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, Page.find(page.id))
		end
	end

	context "Receptionists' permissions" do
		it "must allow Receptionists to read pages" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:read, Page.find(page.id))
		end
		
		it "must prevent Receptionists from creating pages" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:create, Page.new(@valid_page))
		end
		
		it "must prevent Receptionists from editing pages" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:update, Page.find(page.id))
		end
		
		it "must prevent Receptionists from deleting pages" do
			allow(controller).to receive(:current_user).and_return(receptionist)
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Page.find(page.id))
		end
	end
	
	context "Patients' permissions" do
		it "must allow Patients to read pages" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Page.find(page.id))
		end
		
		it "must prevent Patients from creating pages" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:create, Page.new(@valid_page))
		end
		
		it "must prevent Patients from editing pages" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:update, Page.find(page.id))
		end
		
		it "must prevent Patients from deleting pages" do
			allow(controller).to receive(:current_user).and_return(patient)
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:destroy, Page.find(page.id))
		end
	end

 end
