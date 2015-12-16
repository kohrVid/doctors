require 'rails_helper'

RSpec.describe "Contact", :type => :request do
	it "must send valid message using the Contact form" do
		visit new_contact_path
		fill_in "Name", with: "Tobey Torres"
		fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
		fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
		fill_in "Nickname", with: ""
		click_button "Send"
		expect(page.body).to have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
		expect(last_email.to).to include("no-reply@thedoctors.com")
		expect(last_email.from).to include("kohrVid@gmail.com")
	end
	
	it "must not send message without name" do
		visit new_contact_path
		fill_in "Name", with: ""
		fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
		fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
		fill_in "Nickname", with: ""
		click_button "Send"
		expect(page.body).to have_content("Unable to send message.")
		expect(page.body).to have_content("Name can't be blank")
		expect(last_email).to be_nil
	end

	it "must not send message without valid email" do
		visit new_contact_path
		fill_in "Name", with: "Tobey Torres"
		fill_in "Email", with: ""
		fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
		fill_in "Nickname", with: ""
		click_button "Send"
		expect(page.body).to have_content("Unable to send message.")
		expect(page.body).to have_content("Email can't be blank")
		expect(last_email).to be_nil
	end
	
	it "must not send message without message" do
		visit new_contact_path
		fill_in "Name", with: "Tobey Torres"
		fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
		fill_in "Message", with: ""
		fill_in "Nickname", with: ""
		click_button "Send"
		expect(page.body).to have_content("Unable to send message.")
		expect(page.body).to have_content("Message can't be blank")
		expect(last_email).to be_nil
	end

	it "must not deliver spam" do
		visit new_contact_path
		fill_in "Name", with: "Rick"
		fill_in "Email", with: "RRoll@4chan.com"
		fill_in "Message", with: "Never gonna give you up!"
		fill_in "Nickname", with: "RickRollz"
		click_button "Send"
		click_button "Send"
		expect(page.body).to have_content("Unable to send message.")
		expect(last_email).to be_nil
	end
end
