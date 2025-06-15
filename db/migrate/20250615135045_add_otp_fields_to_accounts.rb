class AddOtpFieldsToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :otp_code, :string
    add_column :accounts, :otp_sent_at, :datetime
  end
end
