class DemandsController < ApplicationController
  before_action :set_demand, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @filtered_demands = Demand.search(params[:q])
    demands = policy_scope(@filtered_demands.result(distinct: true).page(params[:page]))
    authorize demands
    @demands = DemandDecorator.decorate_collection(demands)
  end

  def show
    authorize @demand
  end

  def edit
    authorize @demand
  end

  def update
    authorize @demand
    if @demand.update(demand_params)
      redirect_to @demand
    else
      render :edit
    end
  end

  def destroy
    authorize @demand
    @demand.destroy
    redirect_to demands_path
  end

  private
    def set_demand
      @demand = Demand.find(secure_id).decorate
    end

    def secure_id
      params[:id].to_i
    end

    def demand_params
      params.require(:demand).permit(:city, :service_category_id, :service_id, :vin_number, :brand, :model, :year, :engine, :engine_letters, :name_and_surnames, :phone, :email, :wants_newsletter, :accepts_privacy, :comments, :demand_details)
    end
end
