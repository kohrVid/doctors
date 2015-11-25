class User < ActiveRecord::Base
	before_validation :downcase_username, :downcase_email
	has_many :doctors, class_name: "User", foreign_key: "doctor_id"
	has_many :patients, class_name: "User", foreign_key: "patient_id"
	has_many :appointments
	has_one :address, dependent: :destroy
	accepts_nested_attributes_for :address

	acts_as_authentic do |c|
		c.login_field = :username
		c.validate_email_field = false
		c.crypto_provider = Authlogic::CryptoProviders::BCrypt
	end
	
	VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 


	validates :first_name, presence: true, length: {maximum: 50}
	validates :middle_name, length: {maximum: 75}
	validates :last_name, presence: true, length: {maximum: 50}
	validates :username, presence: true, length: {maximum: 15}, uniqueness: true, exclusion: {in: %w(admin moderator webmaster webadmin administrator adm)}
	validates :email, length: {maximum: 255}, allow_blank: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
	validates :password, length: {minimum: 6}
	validates :phone, presence: true
	validates :address, presence: true

	def active?
		if self.locked == false
			return true
		else
			return false
		end
	end

	def approved?
		if self.approved == true
			return true
		else
			return false
		end
	end

	private
		def downcase_username
			self.username = self.username.downcase if self.username.present?
		end

		def downcase_email
			self.email = self.email.downcase if self.email.present?
		end

end
