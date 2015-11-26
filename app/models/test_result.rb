class TestResult < ActiveRecord::Base
	delegate :patients, to: :users

end
