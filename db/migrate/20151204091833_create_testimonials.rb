class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
	    t.text :author
	    t.date :date, default: Time.now
	    t.text :body

      t.timestamps null: false
    end
  end
end
