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
			post "create", user: {username: "ttorres", password: "TheSmiths"}
			expect(response).to be_success
		end
	end

	context "Approval" do
		it "must be unable to log in if unapproved"
	end

	context "locked account" do
		it "must be unable to login if locked"
	end

end
