require 'elasticsearch/model'
class Page < ActiveRecord::Base	
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged]
	validates :title, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 10 }
	

	def slug_candidates
		[
			:title,
			[:title, :id]
		]
	end

	settings index: { number_of_shards: 1 } do
		mappings dynamic: "false" do
			indexes :title, analyzer: "english", index_options: "offsets"
			indexes :description, analyzer: "english"
		end
	end
	
	def self.search(query)
		__elasticsearch__.search(
			{
				query: {
					multi_match: {
						query: query,
						fields: ["title^10", "description"]
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
