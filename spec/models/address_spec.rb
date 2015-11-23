require 'rails_helper'

RSpec.describe Address, type: :model do
	before do
		@valid_address = {
		    user: "",
		    street: "33 Vulcan",
		    address_line2: "Snake River",
		    city: "San Francisco",
		    county: "California",
		    post_code: "CA9 O21"
		}
	end
end
