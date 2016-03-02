require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

Bundler.require(*Rails.groups)

module Ewoks
  class Application < Rails::Application

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: [:get, :post, :delete, :put, :patch, :options, :head],
          max_age: 0
      end
    end

    config.before_configuration do
      env_file = '/home/ubuntu/rails/ewok/shared/config/local_env.yml'
      env_file = File.join(Rails.root, 'config', 'local_env.yml') unless File.exists?(env_file)
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.to_prepare do
      Devise::SessionsController.layout "devise"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "devise" }
      Devise::ConfirmationsController.layout "devise"
      Devise::UnlocksController.layout "devise"
      Devise::PasswordsController.layout "devise"
    end

    config.i18n.available_locales = ['it', 'pl', 'pt', 'fr', 'es', 'be', 'en']

    config.exceptions_app = routes
  end
end
