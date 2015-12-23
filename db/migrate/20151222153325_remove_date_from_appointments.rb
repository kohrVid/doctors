class RemoveDateFromAppointments < ActiveRecord::Migration
  def change
	  remove_column :appointments, :date, :date
  end
end
