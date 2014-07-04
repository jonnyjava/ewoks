Rails.application.routes.draw do
  root to: "garages#index"

  resources :users
  resources :holidays
  resources :properties
  resources :garages do
    resources :fees
    resources :tyre_fees
    resources :holidays
    resources :timetables
    resources :garage_properties, path: 'properties', as: 'properties'
  end

  resources :properties
  resources :garage_properties

  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  patch 'garages/:id/toggle_status', to: 'garages#toggle_status', as: 'toggle_status'
  delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'
end
