class ServicesController < ApplicationController
  after_action :verify_authorized

  def index
    @services = Service.all
    authorize @services
  end
end
