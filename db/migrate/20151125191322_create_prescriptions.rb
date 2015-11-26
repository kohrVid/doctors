class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
	    t.belongs_to :patient, polymorphic: true
	    t.time :date
	    t.text :drug
	    t.text :status
      t.timestamps null: false
    end
  end
end
