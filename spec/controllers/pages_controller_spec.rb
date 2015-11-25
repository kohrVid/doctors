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

	context "Permissions" do
		it "must be allow Doctors to edit pages"
		it "must be allow Admins to edit pages"
		it "must prevent Reception from edit pages"
		it "must prevent patients from edit pages"
	end

 end
