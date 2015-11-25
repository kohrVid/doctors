require 'rails_helper'

RSpec.describe "users/edit.html.erb", type: :view do
	it "must not be visible to other patients"
	it "must not allow patients to approve themselves"
	it "must be visible to reception, doctors and admin"

end
