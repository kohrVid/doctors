class Page < ActiveRecord::Base
	
	validates :title, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 10 }
	
end
