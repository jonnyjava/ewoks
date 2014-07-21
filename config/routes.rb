Rails.application.routes.draw do
  root to: "garages#index"

  namespace :api do
    namespace :v1 do
      resources :garages, only: [:index, :show]
    end
  end

  get '/success', to:'public_form#success', as: 'success'
  get '/public_form', to:'public_form#public_form', as: 'public_form'
  post '/public_form', to:'public_form#create', as: 'public_form_create'

  resources :garages do
    resources :fees
    resources :tyre_fees
    resources :holidays
    resources :timetables
    resources :garage_properties, path: 'properties', as: 'properties'
  end
  resources :properties

  resources :users
  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  patch 'garages/:id/toggle_status', to: 'garages#toggle_status', as: 'toggle_status'
  delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'
end
