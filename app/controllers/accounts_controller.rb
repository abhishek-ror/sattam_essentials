class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if Account.exists?(email: params[:account][:email])
      render json: { errors: ["Email has already been taken"] }, status: :unprocessable_entity
      return
    end
    account = Account.new(account_params)
    if account.save
      account.generate_otp!
      # Send OTP logic...
      render json: { message: "OTP sent to your email.", account_id: account.id }, status: :created
    else
      render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    account = Account.find_by(email: params[:email])
    if account&.valid_password?(params[:password])
      account.generate_otp!
      render json: { message: "OTP sent to your email.", account_id: account.id }
    else
      render json: { errors: ["Invalid email or password"] }, status: :unauthorized
    end
  end

  def verify_otp
    account = Account.find_by(id: params[:account_id])
    if account&.otp_valid?(params[:otp_code])
      account.update(activated: true)
      account.clear_otp!
      token = Warden::JWTAuth::UserEncoder.new.call(account, :user, nil).first
      render json: { message: "OTP Verified", token: token }
    else
      account.update(activated: false) if account
      render json: { errors: ["Invalid or expired OTP"] }, status: :unauthorized
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation, :role, :activated)
  end
end
