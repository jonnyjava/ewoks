module API
  class GaragesController < ApplicationController
    skip_before_filter :authenticate_user!

    def index
      garages = Garage.active
      country = params[:country]
      city = params[:city]
      zip = params[:zip]
      radius = params[:radius]
      price = params[:tyre_fee]

      if radius
        location = [city, zip, country].compact.join(', ')
        garages = garages.find_by_radius_from_location(location, radius)
      else
        garages = garages.by_country(country) if country
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
  end
end
