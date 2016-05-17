class ServicesController < ApplicationController
  before_action :set_service, only: [:edit, :update]
  after_action :verify_authorized

  def index
    @services = Service.includes(:service_category)
    authorize @services
  end

  def edit
    authorize @service
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to service_categories_url
    else
      render :index
    end
  end

  private

  def set_service
    @service = Service.find(secure_id)
  end

  def secure_id
    params[:id].to_i
  end

  def service_params
    params.require(:service).permit(:id, :name)
  end
end
