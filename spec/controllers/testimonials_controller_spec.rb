require 'rails_helper'

RSpec.describe TestimonialsController, type: :controller do
	let(:patient) { FactoryGirl.create(:patient) }
	let(:receptionist) { FactoryGirl.create(:receptionist) }
	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:admin) { FactoryGirl.create(:admin) }
	let(:testimonial) { FactoryGirl.create(:testimonial) }
	
	context "Non-Users" do
		it "should be unable to create testimonials" do
			expect { get :new }.to raise_error(CanCan::AccessDenied)
		end

		it "should be able to view testimonials" do
			expect(get :show, id: testimonial.id).to be_success
		end
		
		it "should be unable to edit testimonials" do
			expect { get :edit, id: testimonial.id }.to raise_error(CanCan::AccessDenied)
		end
		
		it "should be unable to delete testimonials" do
			expect { delete :destroy, id: testimonial.id }.to raise_error(CanCan::AccessDenied)
		end
	end

	context "Patient" do	
		before(:each) do
			allow(controller).to receive(:current_user).and_return(patient)
		end

		it "must be unable to create new testimonials" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:create, Testimonial.new)
		end
		
		it "must be unable to see index" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:index, Testimonial.new)
		end
		
		it "must be able to view testimonials" do	
			ability = Ability.new(patient)
			expect(ability).to be_able_to(:read, Testimonial.find(testimonial.id))
		end
		
		it "must be unable to update testimonials" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:update, Testimonial.find(testimonial.id))
		end
		
		it "must be unable to delete testimonials" do 		
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:destroy, Testimonial.find(testimonial.id))
		end
	end

	context "Receptionist" do	
		before(:each) do
			allow(controller).to receive(:current_user).and_return(receptionist)
		end

		it "must be unable to create new testimonials" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:create, Testimonial.new)
		end
		
		it "must be unable to see index" do
			ability = Ability.new(patient)
			expect(ability).to_not be_able_to(:index, Testimonial.new)
		end
		
		it "must be able to view testimonials" do	
			ability = Ability.new(receptionist)
			expect(ability).to be_able_to(:read, Testimonial.find(testimonial.id))
		end
		
		it "must be unable to update testimonials" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:update, Testimonial.find(testimonial.id))
		end
		
		it "must be unable to delete testimonials" do
			ability = Ability.new(receptionist)
			expect(ability).to_not be_able_to(:destroy, Testimonial.find(testimonial.id))
		end
	end

	context "Doctor" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(doctor)
		end
		
		it "must be able to create new testimonials" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:create, Testimonial.new)
		end
		
		it "must be able to view testimonials" do	
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:read, Testimonial.find(testimonial.id))
		end
		
		it "must be able to update testimonials" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:update, Testimonial.find(testimonial.id))
		end
		
		it "must be able to delete testimonials" do
			ability = Ability.new(doctor)
			expect(ability).to be_able_to(:destroy, Testimonial.find(testimonial.id))
		end
	end

	context "Admin" do
		before(:each) do
			allow(controller).to receive(:current_user).and_return(admin)
		end
		
		it "must be able to create new testimonials" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:create, Testimonial.new)
		end

		it "must be able to view testimonials" do	
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:read, Testimonial.find(testimonial.id))
		end
		
		it "must be able to update testimonials" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:update, Testimonial.find(testimonial.id))
		end
		
		it "must be able to delete testimonial accounts" do
			ability = Ability.new(admin)
			expect(ability).to be_able_to(:destroy, Testimonial.find(testimonial.id))
		end
	end

end
