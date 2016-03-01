Rails.application.routes.draw do
  resources :garage_recruitables

  root to: 'garages#index'

  namespace :api do
    namespace :v1 do
      resources :garages, only: [:index, :show]
      resources :garage_registrations, only: [:create, :update]
    end
  end

  get 'garages/signup_verification/:token', to: 'garages#signup_verification', as: 'signup_verification'

  scope '(:locale)', locale: /it|pl|pt|fr|es|be|en/ do
    get '/success', to: 'public_form#success', as: 'success'
    get '/public_form', to: 'public_form#public_form', as: 'public_form'
    post '/public_form', to: 'public_form#create', as: 'public_form_create'
    get '/wizard', to: 'wizard#wizard', as: 'wizard'
    post '/wizard_create_garage', to: 'wizard#create_garage', as: 'wizard_create_garage'
    get '/wizard_timetable/:garage_id', to: 'wizard#timetable', as: 'wizard_timetable'
    patch '/wizard_update_timetable/:garage_id', to: 'wizard#update_timetable', as: 'wizard_update_timetable'
    get '/wizard_holiday/:garage_id', to: 'wizard#holiday', as: 'wizard_holiday'
    post '/wizard_create_holiday/:garage_id', to: 'wizard#create_holiday', as: 'wizard_create_holiday'
    get '/wizard_fee/:garage_id', to: 'wizard#fee', as: 'wizard_fee'
    post '/wizard_create_fee/:garage_id', to: 'wizard#create_fee', as: 'wizard_create_fee'

    resources :garages do
      resources :tyre_fees
      resources :holidays
      resources :timetables
      resources :garage_properties, path: 'properties', as: 'properties'
    end

    resources :properties
    resources :users

    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    }

    patch 'garages/:id/toggle_status', to: 'garages#toggle_status', as: 'toggle_status'
    patch 'users/:id/regenerate_auth_token', to: 'users#regenerate_auth_token', as: 'regenerate_auth_token'
    delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'

    match '/404' => 'errors#error_404', via: :all, as: 'error_404'
    match '/422' => 'errors#error_422', via: :all, as: 'error_422'
    match '/500' => 'errors#error_500', via: :all, as: 'error_500'
    match '*path', to: 'errors#error_404', via: :all
  end
end
