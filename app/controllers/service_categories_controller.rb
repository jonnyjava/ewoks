class ServiceCategoriesController < ApplicationController
  after_action :verify_authorized

  def index
    @service_categories = ServiceCategory.all
    authorize @service_categories
  end
end
