Rails.application.routes.draw do
  # Devise routes for admin panel (ActiveAdmin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :accounts

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Set the root path if needed
  # root "home#index"
end
