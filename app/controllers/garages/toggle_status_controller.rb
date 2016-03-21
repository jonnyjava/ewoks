module Garages
  class ToggleStatusController < ApplicationController
    before_action :set_garage, only: :update
    after_action :verify_authorized

    def update
      authorize @garage
      @garage.toggle_status
      respond_to do |format|
        format.html { redirect_to garages_url }
      end
    end

    private
      def set_garage
        @garage = Garage.find(garage_params[:id])
      end

      def garage_params
        params.permit(:id)
      end
  end
end
