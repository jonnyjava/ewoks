module API
  module V1
    class GaragesController < ApplicationController
      include TokenAuthenticationForApiControllers

      skip_before_filter :authenticate_user!
      before_action :authenticate

      def index
        radius = garage_params[:radius]
        price = garage_params[:price]
        price_min = garage_params[:price_min] ? garage_params[:price_min].to_i : nil
        price_max = garage_params[:price_max] ? garage_params[:price_max].to_i : nil
        rim = garage_params[:rim]
        vehicle = garage_params[:vehicle]
        diameter = garage_params[:diameter]
        zip = garage_params[:zip]
        city = garage_params[:city]
        service_id = garage_params[:service_id]
        country = set_country
        garages = Garage.active.by_price(price).by_rim(rim).by_vehicle(vehicle).by_diameter(diameter).by_country(country).by_service(service_id)

        if price_min || price_max
          garages = garages.by_price_in_a_range(price_min, price_max)
        end

        if radius
          garages = garages.find_by_radius_from_location(location(country), radius)
        else
          garages = garages.by_default(zip, city)
        end
        @garages = garages
        @tyre_fees = TyreFee.where(garage_id: @garages.map(&:id)).by_price(price).by_rim(rim).by_vehicle(vehicle).by_diameter(diameter)
      end

      def show
        @garage = Garage.find(secure_id)
        @holidays = @garage.holidays.all
      end

    private

      def set_country
        garage_params[:country] || @current_user.country
      end

      def location(country)
        [garage_params[:city], garage_params[:zip], country].compact.join(', ')
      end

      def garage_params
        params.permit(:id, :city, :country, :zip, :radius, :price, :price_min, :price_max, :rim, :vehicle, :diameter, :service_id)
      end

      def secure_id
        garage_params[:id].to_i
      end
    end
  end
end
