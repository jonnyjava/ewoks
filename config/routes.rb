Rails.application.routes.draw do
  root to: 'garages#index'

  get 'garages/signup_verification/', to: 'garages#signup_verification', as: 'signup_verification'

  namespace :api do
    namespace :v1 do
      resources :demands, only: [:create]
      resources :garages, only: [:index, :show]
      resources :garage_registrations, only: [:create, :update]
      resources :garage_recruitables, only: [:show, :update], param: :token
      resources :quote_proposals, only: [:show, :update], param: :token
      resources :services, only: :index
    end
  end

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

    resources :service_categories, only: :index
    resources :services, only: [:index, :edit, :update]
    resources :service_definitions, except: [:show, :edit]
    resources :demands, except: [:new, :create]
    resources :quote_proposals, except: :new do
      collection do
        get 'new/:demands_garage_id', to: "quote_proposals#new", as: 'new'
      end
    end
    namespace :quotables do
      resources :deliver, only: :update
    end

    resources :garages do
      resources :tyre_fees, except: :show
      resources :holidays
      resources :timetables
    end
    namespace :garages do
      resources :toggle_status, only: :update
    end

    resources :users

    resources :garage_recruitables, except: :new
    namespace :recruitables do
      resources :export, only: :index
    end

    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    }

    patch 'users/:id/regenerate_auth_token', to: 'users#regenerate_auth_token', as: 'regenerate_auth_token'
    delete 'garages/:id/destroy_logo', to: 'garages#destroy_logo', as: 'destroy_logo'

    match 'public/404' => 'errors#error_404', via: :all, as: 'error_404'
    match 'public/422' => 'errors#error_422', via: :all, as: 'error_422'
    match 'public/500' => 'errors#error_500', via: :all, as: 'error_500'
    match '*path', to: 'errors#error_404', via: :all
  end
end
