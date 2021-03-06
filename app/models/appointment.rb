#require 'elasticsearch/model'
class Appointment < ActiveRecord::Base
#	include Elasticsearch::Model
#	include Elasticsearch::Model::Callbacks
	belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
	belongs_to :patient, class_name: "User", foreign_key: "patient_id"

	validates :doctor, presence: true
	validates :patient, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	
	validates :start_time, :end_time, overlap: {
		exclude_edges: ["start_time", "end_time"],
		scope: "doctor_id",
		scope: "cancelled"
	}

	validates :start_time, :end_time, overlap: {
		exclude_edges: ["start_time", "end_time"],
		active: false,
		scope: "patient_id",
		scope: "cancelled"
	}


	def today?
		if start_time > DateTime.now.beginning_of_day && start_time < DateTime.now.end_of_day
			return true
		end
	end
			


	private

		def active?
			if cancelled == true
				return false
			else
				return true
			end
		end

end
