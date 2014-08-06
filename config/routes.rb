Rails.application.routes.draw do
  root to: 'garages#index'

  namespace :api do
    namespace :v1 do
      resources :garages, only: [:index, :show]
    end
  end

  scope '(:locale)', locale: /en|es|pt|pl/ do
    get '/success', to: 'public_form#success', as: 'success'
    get '/public_form', to: 'public_form#public_form', as: 'public_form'
    post '/public_form', to: 'public_form#create', as: 'public_form_create'
    get 'garages/signup_verification/:token', to: 'garages#signup_verification', as: 'signup_verification'
  end

  scope '(:locale)', locale: /en|es|pt|pl/ do
    resources :garages do
      resources :fees
      resources :tyre_fees
      resources :holidays
      resources :timetables
      resources :garage_properties, path: 'properties', as: 'properties'
    end

    resources :properties
    resources :users

    devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
    patch 'garages/:id/toggle_status', to: 'garages#toggle_status', as: 'toggle_status'
    delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'

    match '/404' => 'errors#error_404', via: :all, as: 'error_404'
    match '/422' => 'errors#error_422', via: :all, as: 'error_422'
    match '/500' => 'errors#error_500', via: :all, as: 'error_500'
    match '*path', to: 'errors#error_404', via: :all
  end
end
