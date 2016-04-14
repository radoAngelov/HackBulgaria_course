class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def remember
    update! remember_digest: SecureRandom.urlsafe_base64
  end

  def forget
    update! remember_digest: nil
  end
end