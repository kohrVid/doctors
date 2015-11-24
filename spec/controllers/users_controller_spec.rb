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
		it "must be unable to approve itself"
		it "must be unable to approve other users"
	end

	context "Doctor" do
		it "must be able to approve new users"
		it "must be able to lock patient accounts"
		it "must not be able to lockout other doctors"
		it "must not be able to delete user accounts"
	end

	context "Reception" do
		it "must be able to create new users"
		it "must be able to reset user passwords"
	end

	context "Admin" do
		it "must be able to approve new users"
		it "must be able to delete doctors"
	end

end
