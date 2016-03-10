module API
  module V1
    class GarageRecruitablesController < ApplicationController
      include TokenAuthenticationForApiControllers

      protect_from_forgery except: [:update]
      skip_before_filter :authenticate_user!
      before_action :authenticate, :set_garage_recruitable

      def show
        head :unprocessable_entity and return unless @garage_recruitable
        if(@garage_recruitable.recruited?)
          render json: {message: t('already_registered')}
        end
      end

      def update
        head :unprocessable_entity and return unless @garage_recruitable

        if @garage_recruitable.update(garage_recruitable_update_params)
          head :ok
        else
          head :bad_request
        end
      end

    private

      def set_garage_recruitable
        @garage_recruitable = GarageRecruitable.find_by_token(garage_recruitable_params[:token])
      end

      def garage_recruitable_params
        params.permit(:token)
      end

      def garage_recruitable_update_params
        params.permit(:token, :status)
      end
    end
  end
end
