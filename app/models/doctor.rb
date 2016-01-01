require 'elasticsearch/model'
class Doctor < User	
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	belongs_to :patients, class_name: "User"
	validates :biography, presence: true, length: {minimum: 10, maximum: 750}

	def self.doctor
		User.doctor
	end

	def dr_full_name
		self.title + " " + self.full_name
	end

	def dr_first_name_last_name
		self.title + " " + self.first_name_last_name
	end
end
