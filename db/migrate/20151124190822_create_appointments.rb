class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
	    t.integer :doctor_id
	    t.integer :patient_id
	    t.string :description
	    t.date :date
	    t.datetime :start_time
	    t.datetime :end_time

      t.timestamps null: false
    end
    add_index :appointments, [:doctor_id, :patient_id]
  end
end
