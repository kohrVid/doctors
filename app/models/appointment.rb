class Appointment < ActiveRecord::Base
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


	private

	def cancelled?
		if self.cancelled == true
			return true
		else
			return false
		end
	end
	def active?
		if self.cancelled == true
			return false
		else
			return true
		end
	end

end
