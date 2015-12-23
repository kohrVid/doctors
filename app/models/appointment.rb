class Appointment < ActiveRecord::Base
	belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
	belongs_to :patient, class_name: "User", foreign_key: "patient_id"

	validates :doctor, presence: true
	validates :patient, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :start_time, :end_time, overlap: {
		exclude_edges: ["start_time", "end_time"],
		scope: "doctor_id"
	}
	validates :start_time, :end_time, overlap: {
		exclude_edges: ["start_time", "end_time"],
		scope: "patient_id"
	}
end
