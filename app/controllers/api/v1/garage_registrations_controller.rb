module API
  module V1
    class GarageRegistrationsController < ApplicationController
      include TokenAuthenticationForApiControllers

      protect_from_forgery except: [:create, :update]
      skip_before_filter :authenticate_user!
      before_action :authenticate
      before_action :set_garage, only: :update

      def create
        @garage_registration = GarageRegistration.new(garage_registration_params)
        if @garage_registration.save
          @garage_registration
        else
          render json: {errors: @garage_registration.errors}
        end
      end

      def update
        @garage.assign_services(assignable_services)
        @garage
      end

      private

      def garage_registration_params
        params.permit(:garage_name, :tax_id, :street, :zip, :phone, :email, :password)
      end

      def garage_update_params
        params.permit(:id, service_categories_ids: [])
      end

      def set_garage
        @garage = Garage.find_by_id(garage_update_params[:id])
      end

      def assignable_services
        Service.by_category(garage_update_params[:service_categories_ids])
      end
    end
  end
end
