class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
	    t.integer :doctor_id
	    t.integer :patient_id
	    t.string :description
	    t.date :date
	    t.time :start_time
	    t.time :end_time

      t.timestamps null: false
    end
    add_index :appointments, [:doctor_id, :patient_id]
  end
end
