require 'elasticsearch/model'
class Page < ActiveRecord::Base	
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	validates :title, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 10 }
	

	def slug_candidates
		[:title]
	end
end
