class GarageRecruitablesController < ApplicationController
  before_action :set_garage_recruitable, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @filtered_recruitables = GarageRecruitable.ransack(params[:q])
    @filtered_recruitables.sorts = ['status asc', 'name asc'] if @filtered_recruitables.sorts.empty?
    garage_recruitables = @filtered_recruitables.result.page(params[:page])
    authorize garage_recruitables
    @garage_recruitables = GarageRecruitableDecorator.decorate_collection(garage_recruitables)
  end

  def show
    authorize @garage_recruitable
  end

  def edit
    authorize @garage_recruitable
  end

  def create
    @garage_recruitable = GarageRecruitable.new(garage_recruitable_params)
    authorize @garage_recruitable
    respond_to do |format|
      if @garage_recruitable.save
        format.html { redirect_to @garage_recruitable }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @garage_recruitable
    respond_to do |format|
      if @garage_recruitable.update(garage_recruitable_params)
        format.html { redirect_to @garage_recruitable }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @garage_recruitable
    @garage_recruitable.destroy
    respond_to do |format|
      format.html { redirect_to garage_recruitables_url }
    end
  end

  private
    def set_garage_recruitable
      @garage_recruitable = GarageRecruitable.find(secure_id).decorate
    end

    def secure_id
      params[:id].to_i
    end

    def garage_recruitable_params
      params.require(:garage_recruitable).permit(:name, :street, :zip, :city, :email, :phone, :mobile, :tax_id, :province, :status)
    end
end
