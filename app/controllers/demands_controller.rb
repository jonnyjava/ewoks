class DemandsController < ApplicationController
  before_action :set_demand, only: [:show]
  after_action :verify_authorized

  def index
    demands = policy_scope(Demand.all.page(params[:page]))
    authorize demands
    @demands = demands
  end

  def show
    authorize @demand
  end

  private
    def set_demand
      @demand = Demand.find(params[:id])
    end
end
