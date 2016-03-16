module Recruitables
  class ExportController < ApplicationController
    after_action :verify_authorized

    def index
      garage_recruitables = GarageRecruitable.where(id: params[:ids])
      authorize_collection garage_recruitables
      @garage_recruitables = garage_recruitables
      respond_to :xls
    end

    private
      def authorize_collection(authorizable_collection)
        return authorize authorizable_collection if authorizable_collection.blank?
        authorizable_collection.each { |element| authorize element }
      end
  end
end
