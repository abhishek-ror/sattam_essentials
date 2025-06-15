class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  enum role: { customer: "customer", farmer: "farmer" }

  def generate_otp!
    self.otp_code = rand(100000..999999).to_s
    self.otp_sent_at = Time.current
    save!
  end

  # Checks if the OTP is valid
  def otp_valid?(code)
    otp_code == code && otp_sent_at && otp_sent_at > 10.minutes.ago
  end

  # Clears the OTP after use
  def clear_otp!
    update!(otp_code: nil, otp_sent_at: nil)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "role", "activated", "remember_created_at", "reset_password_sent_at", "reset_password_token", "password_reset_token", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
