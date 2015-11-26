class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
	    t.belongs_to :patient, polymorphic: true
	    t.text :name
	    t.date :date_of_diagnosis
	    t.boolean :medication
      t.timestamps null: false
    end
  end
end
