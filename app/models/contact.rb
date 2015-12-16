class Contact < MailForm::Base
	VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	attribute :name, validate: true, presence: true, length: { minimum: 2, maximum: 75 }
	attribute :email, validate: true, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
	attribute :message, validate: true
	attribute :nickname, captcha: true
	def headers
		{
			:subject => "The Doctor's Contact Form",
			:to => "kohrVid@gmail.com",
			:from => %("#{name}" <#{email}>)

		}
	end

end
