class Doctor < User
	belongs_to :patients, class_name: "User"
	validates :biography, presence: true, length: {minimum: 10, maximum: 750}

	def self.doctor
		User.doctor
	end
end
