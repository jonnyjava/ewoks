module API
  module V1
    class GaragesController < ApplicationController
      skip_before_filter :authenticate_user!
      before_action :authenticate

      def index
        garages = Garage.active
        radius = params[:radius]
        price = params[:price]
        country = set_country
        garages = garages.by_price(price) if price

        if radius
          garages = garages.find_by_radius_from_location(location(country), radius)
        else
          garages = garages.by_default(params[:zip], params[:city], country)
        end

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

      private

      def set_country
        params[:country] || @current_user.country
      end

      def location(country)
        [params[:city], params[:zip], country].compact.join(', ')
      end
    end
  end
end
