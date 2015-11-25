class Patient < User
	has_one :preferred_doctor, class_name: "User", foreign_key: "preferred_doctor_id"
end
