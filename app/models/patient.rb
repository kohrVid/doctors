class Patient < User
	has_one :preferred_doctor, class_name: "User", foreign_key: "preferred_doctor_id"
	
	validates :nhs_number, presence: true, length: { is: 10 }
	validates :gender, presence: true, length: { maximum: 5 }

end
