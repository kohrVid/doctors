require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	context "'GET' index" do
		it "should be successful" do
			get "index"
			expect(response).to be_success
		end

		it "should render the 'index' template" do
			get :index
			expect(response).to render_template("index")
		end
	end
	context "'GET' new" do
		it "should be successful" do
			get "new"
			expect(response).to be_success
		end

		it "should render the 'new' template" do
			get :new
			expect(response).to render_template("new")
		end
	end

	context "Patient" do
		
		it "must be unable to edit other users" do
			u = FactoryGirl.create(:user)
			v = FactoryGirl.create(:doctor)
			UserSession.create(u)
			get "edit", id: v.id
			expect(respond).to_not be_success
			expect(flash).to_not be_empty

		end
		
		it "must be able to edit its attributes" do
		end
		
		it "must be unable to see other non-medical staff's attributes" do
		end

		it "must be able to see its attributes" do
		end
	end

	context "Doctor" do
		it "must be able to approve new users"
		it "must be able to lock patient accounts"
		it "must not be able to lockout other doctors"
		it "must not be able to delete user accounts"
	end

	context "Reception" do	it "must be able to create new users"
		it "must be able to create new users"
		it "must be able to reset user passwords"
	end

	context "Admin" do
		it "must be able to approve new users"
		it "must be able to delete doctors"
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
