require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
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

end
