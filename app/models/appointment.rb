class Appointment < ActiveRecord::Base
	belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
	belongs_to :patient, class_name: "User", foreign_key: "patient_id"

	validates_presence_of :doctor, :patient, :date, :start_time, :end_time
end
