class AddActivatedToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :activated, :boolean
  end
end
