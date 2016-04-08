module API
  module V1
    class DemandsController < ApplicationController
      include TokenAuthenticationForApiControllers
      protect_from_forgery except: [:create]

      skip_before_filter :authenticate_user!
      before_action :authenticate

      def create
        @demand = Demand.new(demand_params)
        if @demand.save
          head :ok
        else
          render json: {errors: @demand.errors}
        end
      end


    private
      def set_country
        @current_user.country
      end

      def demand_params
        params.require(:demand).permit(:city, :service_category_id, :service_id, :vin_number, :brand, :model, :year, :engine, :engine_letters, :name_and_surnames, :phone, :email, :wants_newsletter, :accepts_privacy, :comments, :demand_details)
      end
    end
  end
end
