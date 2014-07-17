module API
  module V1
    class GaragesController < ApplicationController
      skip_before_filter :authenticate_user!
      before_action :authenticate

      def index
        garages = Garage.active
        country = params[:country]
        city = params[:city]
        zip = params[:zip]
        radius = params[:radius]
        price = params[:tyre_fee]

        country = @current_user.country unless country

        if radius
          location = [city, zip, country].compact.join(', ')
          garages = garages.find_by_radius_from_location(location, radius)
        else
          garages = garages.by_country(country)
          garages = garages.by_city(city) if city
          garages = garages.by_zip(zip) if zip
        end
        garages = garages.with_tyre_fee_less_than(price) if price
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
        authenticate_with_http_token do |token, options|
          @current_user = User.find_by_auth_token(token)
        end
      end

      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401
      end
    end
  end
end
