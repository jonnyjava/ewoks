Rails.application.routes.draw do
  root to: "garages#index"

  resources :users
  resources :tyre_fees
  resources :properties
  resources :garage_properties
  resources :garages do
    resources :holidays
  end

  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  patch 'garages/:id/toggle_status', to: 'garages#toggle_status', as: 'toggle_status'
  delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'
end
