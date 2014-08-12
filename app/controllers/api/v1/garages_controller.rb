module API
  module V1
    class GaragesController < ApplicationController
      skip_before_filter :authenticate_user!
      before_action :authenticate
      before_action :set_country, :set_location, only: :index

      def index
        garages = Garage.active

        garages = filtered_by_price(
                  garages, params[:tyre_fee]) if params[:tyre_fee]
        garages = filtered_by_radius(
                  garages, params[:radius]) if params[:radius]
        garages = filtered_by_default(garages, params) unless params[:radius]

        @garages = garages
      end

      def show
        @garage = Garage.find(params[:id])
        @holidays = @garage.holidays.all
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

      def filtered_by_radius(garages, radius)
        garages.find_by_radius_from_location(@location, radius)
      end

      def filtered_by_price(garages, price)
        garages.with_tyre_fee_less_than(price)
      end

      def filtered_by_default(garages, params)
        garages = garages.by_zip(params[:zip]) if params[:zip]
        garages = garages.by_city(params[:city]) if params[:city]
        garages.by_country(@country)
      end

      private

      def set_country
        @country = params[:country] || @current_user.country
      end

      def set_location
        @location = [params[:city], params[:zip], @country].compact.join(', ')
      end
    end
  end
end
