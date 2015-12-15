class Contact < MailForm::Base
	VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :name, presence: true, length: { minimum: 2, maximum: 75 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
end
