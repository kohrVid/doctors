require 'rails_helper'

RSpec.describe "Contact", :type => :request do
	
	it "must send valid message using the Contact form" do
		visit new_contact_path
		fill_in "Name", with: "Tobey Torres"
		fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
		fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
		fill_in "Nickname", with: ""
		click_button "Send"
		expect(page).to have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
		expect(last_email.to).to include("kohrVid@gmail.com")
		expect(last_email.from).to include("ttorres@snakeriverconspiracy.com")
	end
	
	it "must not deliver spam" do
		visit new_contact_path
		fill_in "Name", with: "Rick"
		fill_in "Email", with: "RRoll@4chan.com"
		fill_in "Message", with: "Never gonna give you up!"
		fill_in "Nickname", with: "RickRollz"
		click_button "Send"
		expect(page).to have_content("Unable to send message")
		expect(last_email).to be_nil
	end

	context "Name" do
		it "must not send message without name" do
			visit new_contact_path
			fill_in "Name", with: ""
			fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
			fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Name can't be blank")
			expect(last_email).to be_nil
		end
		
		it "must be at least 2 characters long" do
			visit new_contact_path
			fill_in "Name", with: "c"
			fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
			fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Name is too short (minimum is 2 characters)")
			expect(last_email).to be_nil
		end

		it "must be no longer than 75 characters" do
			visit new_contact_path
			fill_in "Name", with: "c"*76
			fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
			fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Name is too long (maximum is 75 characters)")
			expect(last_email).to be_nil
		end
	end

	context "Email Address" do
		it "must not send message without an email address" do
			visit new_contact_path
			fill_in "Name", with: "Tobey Torres"
			fill_in "Email", with: ""
			fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Email can't be blank")
			expect(last_email).to be_nil
		end
		
		it "must not exceed 255 characters" do
			visit new_contact_path
			fill_in "Name", with: "Tobey Torres"
			fill_in "Email", with: "c"*231+"@snakeriverconspiracy.com"
			fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Email is too long (maximum is 255 characters)")
			expect(page).to have_content("")
			expect(last_email).to be_nil
		end
		
		invalid_email_address = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com)
		invalid_email_address.each do |email_address|
			it "must not send message without a valid email address" do
				visit new_contact_path
				fill_in "Name", with: "Tobey Torres"
				fill_in "Email", with: email_address
				fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
				fill_in "Nickname", with: ""
				click_button "Send"
				expect(page).to have_content("Unable to send message")
				expect(page).to have_content("Email is invalid")
				expect(last_email).to be_nil
			end
		end
		
		valid_email_address = %w(user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com)
		valid_email_address.each do |email_address|
			it "must send valid message using the Contact form if a valid email address is given" do
				visit new_contact_path
				fill_in "Name", with: "Tobey Torres"
				fill_in "Email", with: email_address
				fill_in "Message", with: "I have a suggestion: prescribe more vicodin!"
				fill_in "Nickname", with: ""
				click_button "Send"
				expect(page).to have_content("Thank you for your message! I try to respond within 24hrs so you should hear from me soon.")
				expect(last_email.to).to include("kohrVid@gmail.com")
				expect(last_email.from).to include(email_address)
			end
		end
	end

	context "Message" do
		it "must not send message without message" do
			visit new_contact_path
			fill_in "Name", with: "Tobey Torres"
			fill_in "Email", with: "ttorres@snakeriverconspiracy.com"
			fill_in "Message", with: ""
			fill_in "Nickname", with: ""
			click_button "Send"
			expect(page).to have_content("Unable to send message")
			expect(page).to have_content("Message can't be blank")
			expect(last_email).to be_nil
		end
	end
end
