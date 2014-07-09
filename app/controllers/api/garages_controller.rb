module API
  class GaragesController < ApplicationController
    skip_before_filter :authenticate_user!
    def index
      garages = Garage.all
      if country = params[:country]
        garages = garages.by_country(country)
      end
      render json: garages, status: 200
    end
  end
end
