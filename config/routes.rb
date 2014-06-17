Rails.application.routes.draw do
  root to: "garages#index"

  resources :users
  resources :holidays
  resources :tyre_fees
  resources :properties
  resources :garages
  resources :garage_properties

  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  patch 'garages/toggle_status/:id', to: 'garages#toggle_status', as: 'toggle_status'
end
