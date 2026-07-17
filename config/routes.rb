Rails.application.routes.draw do
  get "categories/show"
  get "products/index"
  get "products/show"
  devise_for :admin_users

  devise_scope :admin_user do
    get "admin_users/sign_out", to: "devise/sessions#destroy"
  end

  ActiveAdmin.routes(self)
  root "products#index"

resources :products, only: %i[index show]
resources :categories, only: :show
end
