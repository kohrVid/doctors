class AddPreferredDoctorToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :preferred_doctor_id, :integer
  end
end
