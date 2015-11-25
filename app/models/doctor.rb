class Doctor < User
	belongs_to :patients, class_name: "User"
end
