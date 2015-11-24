require 'rails_helper'

RSpec.describe PagesController, type: :controller do
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
	describe "'GET' new" do
		it "should be successful" do
			get "new"
			expect(response).to be_success
		end

		it "should render the index template" do
			get :index
			expect(response).to render_template("index")
		end
	end

	context "Doctors and admins" do
		it "must be able to edit pages"
	end
	context "Patient" do
		it "must be unable to edit pages"
	end


 end
