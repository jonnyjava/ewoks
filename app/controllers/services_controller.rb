class ServicesController < ApplicationController
  after_action :verify_authorized

  def index
    @services = Service.includes(:service_category)
    authorize @services
  end
end
