# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV["deseed"]
	["jpublick", "drhammer", "ghenchman", "jslater", "drgirlfriend"].each do |login|
		User.where(username: login).destroy_all
	end
	Page.where(slug: "medical-info").destroy_all
	Testimonial.where(body: FactoryGirl.build(:testimonial).attributes["body"]).destroy_all
	Testimonial.where(body: "Dr. girlfriend diagnosed my son's hydrocephalus early on and was able to treat it right away.", author: "Rose Whalen").destroy_all
else
	FactoryGirl.create(:admin)
	FactoryGirl.create(:doctor)
	FactoryGirl.create(:receptionist)
	FactoryGirl.create(:patient)
	FactoryGirl.create(:page)
	FactoryGirl.create(:testimonial)
	Testimonial.find_or_create_by(body: "Dr. girlfriend diagnosed my son's hydrocephalus early on and was able to treat it right away.", author: "Rose Whalen")
end
