module API
  module V1
    class ServicesController < ApplicationController
      include TokenAuthenticationForApiControllers
      skip_before_filter :authenticate_user!
      before_action :authenticate

      def index
        @service_categories = ServiceCategory.includes(services: [:service_definitions])
      end
    end
  end
end
