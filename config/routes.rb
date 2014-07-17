Rails.application.routes.draw do
  root to: 'garages#index'

  namespace :api do
    namespace :v1 do
      resources :garages, only: [:index, :show]
    end
  end

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

  match '/404' => 'errors#error_404', via: :all
  match '/422' => 'errors#error_422', via: :all
  match '/500' => 'errors#error_500', via: :all
  match '*path', to: 'errors#error_404', via: :all
end
