class Allergy < ActiveRecord::Base
	delegate :patients, to: :users
end
