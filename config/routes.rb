Rails.application.routes.draw do
  resources :garage_properties

  root to: "garages#index"

  devise_for :users
  resources :users

  resources :holidays

  resources :tyre_fees

  resources :properties

  resources :garages
end
