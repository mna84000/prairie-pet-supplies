Rails.application.routes.draw do
  devise_for :admin_users

  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: %i[index show]
  resources :categories, only: :show
end
