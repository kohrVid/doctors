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

	def self.search(query)
		__elasticsearch__.search(
			{
				query: {
					multi_match: {
						query: query,
						fields: ["title^10", "text"]
					}
				},
				highlight: {
					pre_tags: ["<em>"],
					post_tags: ["</em>"],
					fields: {
						title: {},
						description: {}
					}
				}
			}
		)
	end
end
Page.import(force: true)
