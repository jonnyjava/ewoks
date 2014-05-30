Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users

  resources :holidays

  resources :tyre_fees

  resources :properties

  resources :garages
end
