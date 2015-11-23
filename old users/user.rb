class User < ActiveRecord::Base
  # Include default devise modules. Others available are:# :confirmable, :lockable, :timeoutable and :omniauthable
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :database_authenticatable, :registerable, :lockable,
 #        :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

#  VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

  validates :first_name, presence: true, length: {maximum: 50}
  validates :middle_name, length: {maximum: 75}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :username, presence: true, length: {maximum: 15}, uniqueness: true, :case_sensitive => false 
  validates :email, length: {maximum: 255}#, format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true

=begin
    def login=(login)
	    @login = login
    end

    def login
	    @login || self.username || self.email
    end
  
  def self.find_for_database_authentication(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
		  where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
		  where(conditions.to_h).first
	  end
  end
=end

end
