class AddIsSuperadminToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :is_superadmin, :boolean
  end
end
