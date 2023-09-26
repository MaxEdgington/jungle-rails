class User < ApplicationRecord
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  before_save :downcase_email
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end
  
  private
  
  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end