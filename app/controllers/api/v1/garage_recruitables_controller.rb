module API
  module V1
    class GarageRecruitablesController < ApplicationController
      include TokenAuthenticationForApiControllers

      skip_before_filter :authenticate_user!
      before_action :authenticate

      def show
        @garage_recruitable = GarageRecruitable.find_by_token(garage_recruitable_params[:token])
        status = :ok
        status = :unprocessable_entity unless @garage_recruitable
        render json: @garage_recruitable, status: status
      end

    private

      def garage_recruitable_params
        params.permit(:token)
      end
    end
  end
end
