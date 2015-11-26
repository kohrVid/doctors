class Prescription < ActiveRecord::Base
	delegate :patients, to: :users

end
