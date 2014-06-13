Rails.application.routes.draw do
  root to: "garages#index"

  devise_for :users
  resources :users
  resources :holidays
  resources :tyre_fees
  resources :properties
  resources :garages
  resources :garage_properties

  patch 'garages/toggle_status/:id', to: 'garages#toggle_status', as: 'toggle_status'
end
