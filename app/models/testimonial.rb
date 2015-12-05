class Testimonial < ActiveRecord::Base
	validates :author, presence: true, length: { minimum: 2, maximum: 50}
	validates :body, presence: true, length: { minimum: 3, maximum: 1500 }
end
