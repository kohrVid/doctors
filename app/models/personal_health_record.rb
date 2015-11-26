class PersonalHealthRecord < ActiveRecord::Base
	delegate :patients, to: :users

end
