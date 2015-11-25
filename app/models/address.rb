class Address < ActiveRecord::Base
	belongs_to :user

	validates :street, presence: true, length: { maximum: 75 }
	validates :address_line2, length: { maximum: 75 }
	validates :city, presence: true, length: { maximum: 50 }
	validates :county, presence: true, length: { maximum: 75 }
	validates :post_code, presence: true, length: { maximum: 7 }
	
end
