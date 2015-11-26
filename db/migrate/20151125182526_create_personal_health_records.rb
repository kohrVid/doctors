class CreatePersonalHealthRecords < ActiveRecord::Migration
  def change
    create_table :personal_health_records do |t|
	    t.belongs_to :patient, polymorphic: true
	    t.date :date
	    t.text :record_type
	    t.integer :value
      t.timestamps null: false
    end
  end
end
