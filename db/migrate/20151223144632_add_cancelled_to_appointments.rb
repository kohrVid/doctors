class AddCancelledToAppointments < ActiveRecord::Migration
  def change
	  add_column :appointments, :cancelled, :boolean, default: false
  end
end
