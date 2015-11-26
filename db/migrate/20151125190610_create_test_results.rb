class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
	    t.belongs_to :patient, polymorphic: true
	    t.time :date
	    t.text :name
	    t.text :results
	    t.text :diagnosis

      t.timestamps null: false
    end
  end
end
