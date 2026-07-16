AdminUser.find_or_create_by!(email: "admin@prairiepetsupplies.ca") do |admin|
  admin.password = "Password123!"
  admin.password_confirmation = "Password123!"
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?