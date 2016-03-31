module API
  module V1
    class GarageRegistrationsController < ApplicationController
      include TokenAuthenticationForApiControllers

      protect_from_forgery except: [:create, :update]
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
        services = Service.where(id: garage_update_params[:service_ids])
        if services.present?
          @garage.services << services
          @garage
        else
          render json: {errors: @garage.errors}
        end
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
