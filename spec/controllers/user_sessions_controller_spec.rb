require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
	
	context "'GET' login" do
		it "should be successful" do
			get "new"
			expect(response).to be_success
		end

		it "should render the login template" do
			get :new
			expect(response).to render_template("new")
		end
	end
	
	context "'POST' login" do
		it "should be successful" do
			post "create", user_session: { username: "ttorres", password: "TheSmiths" }
			expect(response).to be_success
		end
	end

	context "Approval" do
		it "must stop unapproved users logging in" do 
			u = FactoryGirl.create(:user)
			u[:approved] = false
			post "create", user_session: { username: "ttorres", password: "TheSmiths"}
			expect(response).to_not be_success
		end
	end

	context "locked account" do
		it "must stop locked users logging in" do 
			u = FactoryGirl.create(:user)
			u[:locked] = true
			post "create", user_session: { username: "ttorres", password: "TheSmiths"}
			expect(response).to_not be_success
		end
	end

end
