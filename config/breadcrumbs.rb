crumb :root do
	link "Home", root_path
end

##Appointments##
crumb :appointments do
	link "Appointments", appointments_path
end

crumb :appointment do |appointment|
	link "#{Patient.find(appointment.patient_id).full_name} - #{appointment.start_time.strftime("%d/%m/%Y %H:%M")}", appointment_path(appointment)
	parent :appointments, appointment
end

crumb :edit_appointment do |appointment|
	link "Edit Appointment", edit_appointment_path(appointment)
	parent :appointment, appointment
end

crumb :new_appointment do
	link "New Appointment", appointments_path
	parent :appointments
end
#######

##Patient Appointments##
crumb :patient_appointments do |patient|
	link "Appointments", patient_appointments_path(patient)
end

crumb :patient_appointment do |patient, patient_appointment|
	link "#{Doctor.find(patient_appointment.doctor_id).dr_first_name_last_name} - #{patient_appointment.start_time.strftime("%d/%m/%Y %H:%M")}", patient_appointment_path(patient, patient_appointment)
	parent :patient_appointments, patient, patient_appointment
end

crumb :edit_patient_appointment do |patient, patient_appointment|
	link "Edit Appointment", patient_appointment_path(patient, patient_appointment)
	parent :patient_appointment, patient, patient_appointment
end

crumb :new_patient_appointment do |patient|
	link "New Appointment", new_patient_appointment_path(patient)
	parent :patient_appointments, patient
end
#######

##Doctor Appointments##
crumb :doctor_appointments do |doctor|
	link "Appointments", doctor_appointments_path(doctor)
end

crumb :doctor_appointment do |doctor, doctor_appointment|
	link "#{Patient.find(doctor_appointment.patient_id).full_name} - #{doctor_appointment.start_time.strftime("%d/%m/%Y %H:%M")}", doctor_appointment_path(doctor, doctor_appointment)
	parent :doctor_appointments, doctor, doctor_appointment
end

crumb :edit_doctor_appointment do |doctor, doctor_appointment|
	link "Edit Appointment", doctor_appointment_path(doctor, doctor_appointment)
	parent :doctor_appointment, doctor, doctor_appointment
end

crumb :new_doctor_appointment do |doctor|
	link "New Appointment", new_doctor_appointment_path(doctor)
	parent :doctor_appointments, doctor
end
#######

##Contact Page##
crumb :contacts do
	link "Get In Touch", contacts_path
end
#######

##Doctors##
crumb :doctors do
	link "Doctors", doctors_path
end

crumb :doctor_calendar do |doctor|
	link "#{Doctor.find(doctor.id).dr_first_name_last_name}'s Calendar", "/doctors/#{doctor.id}/calendar"
	parent :doctors, doctor
end

crumb :doctor do |doctor|
	link "#{doctor.dr_first_name_last_name}", doctor_path(doctor)
	parent :doctors, doctor
end

crumb :edit_doctor do |doctor|
	link "Edit Doctor", edit_doctor_path(doctor)
	parent :doctor, doctor
end

crumb :new_doctor do |doctor|
	link "New Doctor", new_doctor_path(doctor)
	parent :doctors, doctor
end
#######

##Pages resources##
crumb :page do |page|
	link "#{page.title}", page
	parent :root
end

crumb :edit_page do |page|
	link "Edit #{page.title}", page_path(page)
	parent :page, page
end

crumb :new_page do |page|
	link "New Page", pages_path
	parent :root
end
#######

##Patients##
crumb :patients do
	link "Patients", patients_path
end

crumb :patient_calendar do |patient|
	link "#{Patient.find(patient.id).first_name_last_name}'s Calendar", "/patients/#{patient.id}/calendar"
	parent :patients, patient
end

crumb :patient do |patient|
	link "#{patient.first_name_last_name}", patient_path(patient)
	parent :patients, patient
end

crumb :edit_patient do |patient|
	link "Edit Patient", edit_patient_path(patient)
	parent :patient, patient
end

crumb :new_patient do |patient|
	link "New Patient", new_patient_path(patient)
	parent :patients, patient
end

crumb :bulk_patient_approval do
	link "Bulk Patient Approval", bulk_patient_approval_path
	parent :patients
end
#######

##Testimonials##
crumb :testimonials do
	link "Testimonials", testimonials_path
end

crumb :testimonial do |testimonial|
	link "#{testimonial.id}", testimonial_path(testimonial)
	parent :testimonials, testimonial
end

crumb :edit_testimonial do |testimonial|
	link "Edit Testimonial", edit_testimonial_path(testimonial)
	parent :testimonial, testimonial
end

crumb :new_testimonial do |testimonial|
	link "New Testimonial", new_testimonial_path(testimonial)
	parent :testimonials, testimonial
end
#######

##Users##
crumb :users do
	link "Users", users_path
end

crumb :user do |user|
	link "#{user.first_name_last_name}", user_path(user)
	parent :users, user
end

crumb :edit_user do |user|
	link "Edit User", edit_user_path(user)
	parent :user, user
end

crumb :new_user do |user|
	link "New User", new_user_path(user)
	parent :users, user
end

crumb :bulk_user_approval do
	link "Bulk User Approval", bulk_user_approval_path
	parent :users
end
#######

=begin
crumb :searh do
	link "Search", search_path
end

crumb :user_sessions do
	link "User Sessions", user_sessions_path
end
=end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
