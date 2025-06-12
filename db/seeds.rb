AdminUser.find_or_create_by!(email: 'admin@example.com') do |account|
  account.password = 'password'
  account.password_confirmation = 'password'
  account.is_superadmin = false
end

AdminUser.find_or_create_by!(email: 'superadmin@example.com') do |account|
  account.password = 'password'
  account.password_confirmation = 'password'
  account.is_superadmin = true
end
