module API
  module V1
    class GarageRegistrationsController < ApplicationController
      protect_from_forgery except: :create
      skip_before_filter :authenticate_user!
      before_action :authenticate

      def create
        @garage_registration = GarageRegistration.new(garage_registration_params)
        if @garage_registration.save
          @garage_registration
        else
          render json: {errors: @garage_registration.errors}
        end
      end

      def update
        @garage = Garage.find_by_id(garage_update_params[:id])
        if @garage.update_service_ids(garage_update_params[:service_ids])
          @garage
        else
          render json: {errors: @garage.errors}
        end
      end

    protected

      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token|
          @current_user = User.find_by_auth_token(token)
        end
      end

      def render_unauthorized
        headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401
      end

      private

      def garage_registration_params
        params.permit(:garage_name, :tax_id, :street, :zip, :phone, :email, :password)
      end

      def garage_update_params
        params.permit(:id, service_ids: [])
      end
    end
  end
end
