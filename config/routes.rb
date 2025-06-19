Rails.application.routes.draw do
  # Devise routes for admin panel (ActiveAdmin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :accounts

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "admin/dashboard#index"

  post '/accounts/create', to: 'accounts#create'
  post '/accounts/login', to: 'accounts#login'
  post '/accounts/verify_otp', to: 'accounts#verify_otp'
end
