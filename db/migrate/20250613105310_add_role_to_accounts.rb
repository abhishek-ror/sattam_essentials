class AddRoleToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :role, :string
  end
end
