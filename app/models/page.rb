class Page < ActiveRecord::Base
	
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	validates :title, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 10 }
	

	def slug_candidates
		[:title]
	end
end
