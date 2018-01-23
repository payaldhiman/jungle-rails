class User < ActiveRecord::Base
  before_validation :downcase_email
  has_secure_password

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :name, presence: true
  validates_uniqueness_of :email
  validates :password, length: { in: 3..20}

  def self.authenticate_with_credentials (email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  private
  def downcase_email
    self.email = email.downcase if email.present?
  end
end