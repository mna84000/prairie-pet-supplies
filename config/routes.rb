Rails.application.routes.draw do
  devise_for :admin_users
  ActiveAdmin.routes(self)

  # other routes...
end
