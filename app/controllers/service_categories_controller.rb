class ServiceCategoriesController < ApplicationController
  after_action :verify_authorized

  def index
    @service_categories = ServiceCategory.includes(services: :service_definitions)
    authorize @service_categories
  end
end
