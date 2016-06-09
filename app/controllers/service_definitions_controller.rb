class ServiceDefinitionsController < ApplicationController
  before_action :set_service_definition, only: [:show, :edit, :update, :destroy]
  before_action :load_services, only: [:index, :new]
  after_action :verify_authorized

  def index
    @service_definitions = ServiceDefinition.send(filter).order(:name).page(params[:page])
    authorize @service_definitions
  end

  def new
    @service_definition = ServiceDefinition.new
    authorize @service_definition
  end

  def create
    @service_definition = ServiceDefinition.new(service_definition_params)
    authorize @service_definition
    if @service_definition.save
      redirect_to service_definitions_url
    else
      render :new
    end
  end

  def update
    authorize @service_definition
    if @service_definition.update(service_definition_params)
      if service_definition_params[:name]
        redirect_to service_definitions_url
      else
        redirect_to service_categories_url
      end
    else
      render :new
    end
  end

  def destroy
    authorize @service_definition
    @service_definition.destroy
    redirect_to service_definitions_url
  end

  private

  def set_service_definition
    @service_definition = ServiceDefinition.find(params[:id])
  end

  def load_services
    @services = Service.order(:name)
  end

  def service_definition_params
    params.require(:service_definition).permit(:name, :service_id)
  end

  def filter
    params[:assigned].present? ? 'assigned' : 'not_assigned'
  end
end
